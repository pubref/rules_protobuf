load("//bzl:classes.bzl", "CLASSES")
load("//bzl:util.bzl", "invoke", "get_offset_path")

PROTOC = Label("//external:protoc")


def get_outdir(ctx):
  return ctx.var["GENDIR" if ctx.attr.output_to_genfiles else "BINDIR"]


def get_execdir(ctx):

  # Proto root is by default the bazel execution root for this
  # workspace.
  root = "."

  # Compte set of "external workspace roots" that the proto
  # sourcefiles belong to.
  external_roots = []
  for file in ctx.files.protos:
    path = file.path.split('/')
    if path[0] == 'external':
      external_roots += ["/".join(path[0:2])]

  # This set size must be 0 or 1. (all source files must exist in this
  # workspace or the same external workspace).
  roots = set(external_roots)
  if len(roots) > 1:
    fail(
"""
You are attempting simultaneous compilation of protobuf source files that span multiple workspaces (%s).
Decompose your library rules into smaller units having filesets that belong to only a single workspace at a time.
Note that it is OK to *import* across multiple workspaces, but not compile them as file inputs to protoc.
""" % roots
    )

  # If all protos are in an external workspace, set the proto_root to
  # this dir (the location we'll cd into when calling protoc)
  if (len(roots)) == 1:
    root = list(roots)[0]

  # User can augment with the proto_root.
  if ctx.attr.proto_root:
    # Fail if user tries to use relative path segments
    proto_path = ctx.attr.proto_root.split("/")
    if ("" in proto_path) or ("." in proto_path) or (".." in proto_path):
      fail("Proto_root cannot contain empty segments, '.', or '..': %s" % proto_path)
    root += "/".join(proto_path)

  return root


def _protoc(ctx, pkg):

  execdir = pkg.execdir
  protoc = get_offset_path(execdir, ctx.executable.protoc.path)
  imports = ["--proto_path=" + get_offset_path(execdir, i) for i in pkg.imports]
  srcs = [get_offset_path(execdir, p.path) for p in pkg.protos]
  protoc_cmd = [protoc] + list(pkg.args) + imports + srcs
  manifest = ["//" + f.short_path for f in pkg.outputs]

  inputs = list(pkg.inputs)
  outputs = list(pkg.outputs)

  cmds = [" ".join(protoc_cmd)]
  if execdir != ".":
    cmds.insert(0, "cd %s" % execdir)

  if ctx.attr.output_to_workspace:
    print(
"""
>**************************************************************************
* - Generating files into the workspace...  This is potentially           *
*   dangerous (may overwrite existing files) and violates bazel's         *
*   sandbox policy.                                                       *
* - Disregard "ERROR: output 'foo.pb.*' was not created." messages.       *
* - Build will halt following the "not all outputs were created" message. *
* - Output manifest is printed below.                                     *
**************************************************************************<
%s
>*************************************************************************<
""" % "\n".join(manifest)
    )

  if ctx.attr.verbose:
    print(
"""
************************************************************
cd $(bazel info execution_root)%s && \
%s
************************************************************
%s
************************************************************
""" % (
  "" if execdir == "." else "/" + execdir,
  " \\ \n".join(protoc_cmd),
  "\n".join(manifest))
    )

  if ctx.attr.verbose > 2:
    for i in range(len(protoc_cmd)):
      print(" > cmd%s: %s" % (i, protoc_cmd[i]))
    for i in range(len(inputs)):
      print(" > input%s: %s" % (i, inputs[i]))
    for i in range(len(outputs)):
      print(" > output%s: %s" % (i, outputs[i]))

  ctx.action(
    mnemonic = "ProtoCompile",
    command = " && ".join(cmds),
    inputs = inputs,
    outputs = outputs,
  )


def _protoc_rule_impl(ctx):

  if ctx.attr.verbose > 1:
    print("proto_compile %s:%s"  % (ctx.build_file_path, ctx.label.name))

  # Get proto root.  This is usually "."
  execdir = get_execdir(ctx)

  outdir = get_offset_path(execdir, get_outdir(ctx))

  # Configure global outdir to execution root if we want to place them
  # in the workspace.
  if ctx.attr.output_to_workspace:
    outdir = get_offset_path(execdir, ".")

  # Propogate proto deps.  Workaround to use a list since sets cannot
  # contain struct objects.
  pkgs = []
  for dep in ctx.attr.proto_deps:
    for pkg in dep.proto.transitive_pkgs:
      if not pkg in pkgs:
        pkgs += [pkg]


  # Mutable builder-like data structure for preparation phase.
  self = {
    "args": [], # list of string
    "ctx": ctx, # ctx
    "exts": [], # list of string
    "prefix": ":".join([ctx.label.package, ctx.label.name]),
    "imports": [], # list of string
    "inputs": [], # list of string
    "outdir": outdir, # string
    "pkgs": pkgs, # set(struct)
    "protos": ctx.files.protos, # list of File
    "execdir": execdir, # string
    "outputs": [], # list of File
    "with_grpc": getattr(ctx.attr, "with_grpc", False), # boolean
  }


  # Make a list of languages that were specified for this run
  spec = []

  for name, lang in CLASSES.items():
    if ctx.attr.verbose > 2:
      print("gen_%s? %s" % (name, getattr(ctx.attr, "gen_" + name, False)))
    if getattr(ctx.attr, "gen_" + name, False):
      spec += [lang]

  # Prepreprocessing for all requested languages.
  for lang in spec:
    invoke("build_prefix", lang, self)
    invoke("build_generated_filename_extensions", lang, self)
    invoke("build_generated_files", lang, self)
    invoke("build_imports", lang, self)
    invoke("build_protobuf_invocation", lang, self)
    invoke("build_protobuf_out", lang, self)
    if self["with_grpc"] or getattr(ctx.attr, "gen_" + lang.name + "_grpc", False):
      invoke("build_grpc_invocation", lang, self)
      invoke("build_grpc_out", lang, self)
      if ctx.attr.verbose > 2:
        print("gen_" + lang.name + "_grpc = yes")
    invoke("build_inputs", lang, self)


  # Build immutable for rule and transitive beyond
  pkg = struct(
    label = ctx.label,
    workspace_name = ctx.workspace_name,
    execdir = self["execdir"],
    prefix = self["prefix"],
    args = set(self["args"]),
    imports = set(self["imports"]),
    protos = set(self["protos"]),
    inputs = set(self["inputs"]),
    outputs = set(self["outputs"] + ctx.outputs.outs),
  )
  pkgs.append(pkg)

  # Run protoc
  _protoc(ctx, pkg)

  # Postprocessing for all requested languages.
  for lang in spec:
    invoke("post_execute", lang, self)

  return struct(
    files = set(self["outputs"]),
    proto = struct(
      pkg = pkg,
      transitive_pkgs = pkgs,
    ),
  )


def implement(spec):

  self = {
    "attrs": {},
    "outputs": {},
    "output_to_genfiles": False,
  }

  attrs = self["attrs"]

  # Augments the calculated proto root.
  attrs["proto_root"] = attr.string()

  # Options to be passed to protoc as -I.  Raw strings.
  attrs["imports"] = attr.string_list()

  # Options to be passed to protoc as --proto_path.  Label list where
  # the external workspace root foreach named file will be added as an
  # import.
  # NOTE(pcj): not sure if this is actually useful.
  #attrs["proto_paths"] = attr.label_list()

  # The set of files to compile.
  attrs["protos"] = attr.label_list(
    allow_files = FileType([".proto"]),
  )

  # *_proto_{compile,library} rule dependencies.
  attrs["proto_deps"] = attr.label_list(providers = ["proto"])

  # The protoc executable (built from source by default)
  attrs["protoc"] = attr.label(
    default = Label("//external:protoc"),
    # TODO(pcj): isn't HOST_CFG deprecated?
    cfg = HOST_CFG,
    executable = True,
  )

  # Outputs.  Only used by java languages at this point.
  attrs["outs"] = attr.output_list()

  # Flag to place generated files in the bazel workspace.  May violate
  # sandbox constraints.
  attrs["output_to_workspace"] = attr.bool(
    default = False,
  )

  # Verbose levels mostly implemented at 1 and 2
  attrs["verbose"] = attr.int()

  # Flag that sets gen_grpc_{lang} to true for all languages.
  attrs["with_grpc"] = attr.bool()

  # Add attributes foreach language.
  for lang in spec:
    if not CLASSES.get(lang.name): fail("Language not defined in CLASSES: %s" % lang.name)
    invoke("implement_compile_attributes", lang, self)
    invoke("implement_compile_outputs", lang, self)
    invoke("implement_compile_output_to_genfiles", lang, self)

  # Flag to place generated files in bazel-genfiles.  cpp requires
  # genfiles, everyone else not.
  attrs["output_to_genfiles"] = attr.bool(
    default = self["output_to_genfiles"],
  )

  # Support for protoc plugins not defined in this project.
  # Note: not implemented yet. TODO(pcj): implement this.
  #attrs["plugin_name"] = attr.string()
  #attrs["plugin_args"] = attr.string_list()
  #attrs["plugin_binary"] = attr.string_list()
  #attrs["plugin_generated_file_extension"] = attr.string_list()

  #print("attrs: %s" % self["attrs"].keys())

  return rule(
    implementation = _protoc_rule_impl,
    attrs = self["attrs"],
    outputs = self["outputs"],
    output_to_genfiles = self["output_to_genfiles"],
  )
