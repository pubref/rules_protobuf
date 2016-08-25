load("//bzl:util.bzl", "invoke")
load("//bzl:classes.bzl", "CLASSES")

PROTOC = Label("//external:protoc")

def _get_gendir(ctx):
  if ctx.attr.output_to_genfiles:
    return ctx.var["GENDIR"]
  else:
    return ctx.var["BINDIR"]


def _execute_rule(self):
  ctx = self["ctx"]

  srcfiles = [file.short_path for file in self["protos"]]
  arglist = list(set(self["args"]))
  pathlist = ["--proto_path=" + i for i in set(self["imports"])]
  arguments = arglist + pathlist + srcfiles
  inputs = list(set(self["inputs"]))
  outputs = list(set(self["outputs"] + ctx.outputs.outs))

  if ctx.attr.verbose > 2:
    print("protoc executable: " + ctx.executable.protoc.path)
    for i in range(len(arguments)):
      print(" > arg%s: %s" % (i, arguments[i]))
    for i in range(len(inputs)):
      print(" > input%s: %s" % (i, inputs[i]))
    for i in range(len(outputs)):
      print(" > output%s: %s" % (i, outputs[i]))

  manifest = ["//" + file.short_path for file in self["outputs"]]

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
    cmd = "\n****************************************************************\n"
    cmd += "(cd $(bazel info execution_root) && \\"
    cmd += "".join([("\n%s \\" % e) for e in [ctx.executable.protoc.path] + arguments])
    cmd += "\n)"
    cmd += "\n****************************************************************\n"
    cmd += "\n".join(manifest)
    cmd += "\n****************************************************************\n"
    print(cmd)

  ctx.action(
    mnemonic="ProtoCompile",
    executable=ctx.executable.protoc,
    arguments=arguments,
    inputs=inputs,
    outputs=outputs,
  )


def _protoc_rule_impl(ctx):

  if ctx.attr.verbose > 1:
    print("proto_compile %s:%s"  % (ctx.build_file_path, ctx.label.name))

  gendir = _get_gendir(ctx)
  outdir = gendir

  # Configure global outdir to execution root if we want to place them
  # in the workspace.
  if ctx.attr.output_to_workspace:
    outdir = "."

  self = {
    "args": [],
    "ctx": ctx,
    "gendir": gendir,
    "imports": [],
    "outdir": outdir,
    "protos": ctx.files.protos,
    "inputs": [],
    "outputs": [],
    "transitive_packages": {},
    "with_grpc": getattr(ctx.attr, "with_grpc", False),
  }

  # Propogate proto deps:
  for dep in ctx.attr.proto_deps:
    self["transitive_packages"] += dep.proto.transitive_packages

  # Make a list of languages that were specified for this run
  spec = []

  for name, lang in CLASSES.items():
    if ctx.attr.verbose > 2:
      print("gen_%s? %s" % (name, getattr(ctx.attr, "gen_" + name, False)))
    if getattr(ctx.attr, "gen_" + name, False):
      spec += [lang]

  # Prepreprocessing for all requested languages.
  for lang in spec:
    invoke("build_generated_files", lang, self)
    invoke("build_imports", lang, self)
    invoke("build_protobuf_invocation", lang, self)
    invoke("build_protobuf_out", lang, self)
    if self["with_grpc"] or getattr(ctx.attr, "gen_" + lang.name + "_grpc", False):
      if ctx.attr.verbose > 2:
        print("gen_" + lang.name + "grpc=True")
      invoke("build_grpc_invocation", lang, self)
      invoke("build_grpc_out", lang, self)
    invoke("build_inputs", lang, self)

  # Run protoc
  _execute_rule(self)

  # Postprocessing for all requested languages.
  for lang in spec:
    invoke("post_execute", lang, self)

  # Keep a transitive mapping of package names to the protos it
  # generates.  This is primarily used by golang to do import mapping.
  self["packages"] = {
    ctx.label.package + ':' + ctx.label.name: self["protos"],
  }

  return struct(
    files=set(self["outputs"]),
    proto=struct(
      imports = self["imports"],
      packages = self["packages"],
      protos = set(self["protos"]),
      inputs = self["inputs"],
      transitive_packages = self["packages"] + self["transitive_packages"],
    ),
  )


def implement(spec):

  self = {
    "attrs": {},
    "outputs": {},
    "output_to_genfiles": False,
  }

  attrs = self["attrs"]

  # Options to be passed to protoc as --proto_path.
  attrs["imports"] = attr.string_list()

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
