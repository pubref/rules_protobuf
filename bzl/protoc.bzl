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

  #self["args"] += ["--descriptor_set_out=%s" % (descriptor_set_file.path)]

  srcfiles = self["srcfilenames"]
  arglist = list(set(self["args"]))
  pathlist = ["--proto_path=" + i for i in set(self["imports"])]

  arguments = arglist + pathlist + srcfiles
  inputs = list(set(self["requires"]))
  outputs = list(set(self["provides"] + ctx.outputs.outs))

  if ctx.attr.verbose:
    print("protoc executable: " + ctx.executable.protoc.path)
    for i in range(len(arguments)):
      print(" > arg%s: %s" % (i, arguments[i]))
    for i in range(len(inputs)):
      print(" > input%s: %s" % (i, inputs[i]))
    for i in range(len(outputs)):
      print(" > output%s: %s" % (i, outputs[i]))

  if ctx.attr.output_to_workspace:
    manifest = ["//" + file.short_path for file in self["provides"]]
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

  ctx.action(
    mnemonic="ProtoCompile",
    executable=ctx.executable.protoc,
    arguments=arguments,
    inputs=inputs,
    outputs=outputs,
    env = {
    }
  )


def _build_source_files(ctx, self):

  ctx = self.get("ctx", None)
  if ctx == None:
      fail("build_source_files can only be calling in bazel rule context")

  # Copy the proto source to the gendir namespace (where the
  # BUILD rule is called).
  if self.get("copy_protos_to_genfiles", False):
    for srcfile in ctx.files.protos:
      protofile = ctx.new_file(srcfile.basename)
      if self["verbose"]:
        print("Copying source file to build_path %s .. %s" % (srcfile.path, protofile.path))
      ctx.action(
        mnemonic = "CpProtoToPackageGenfiles",
        inputs = [srcfile],
        outputs = [protofile],
        arguments = [srcfile.path, protofile.path],
        command = "cp $1 $2")
      self["srcs"] += [protofile]
      self["srcfilenames"] += [srcfile.short_path]
  else:
    if self["verbose"]:
      print("No Copy source files.")
    for srcfile in ctx.files.protos:
      self["srcs"] += [srcfile]
      self["srcfilenames"] += [srcfile.short_path]

  # This is the key for protoc to see the entire source tree from the
  # workspace root.
  self["imports"] += ["."]


def _protoc_rule_impl(ctx):

  if ctx.attr.verbose:
    print("proto_compile %s:%s"  % (ctx.build_file_path, ctx.label.name))

  gendir = _get_gendir(ctx)
  outdir = gendir

  if ctx.attr.output_to_workspace:
    outdir = "."

  self = {
    "ctx": ctx,
    "gendir": gendir,
    "outdir": outdir,
    "imports": [],
    "args": [],
    "srcs": [],
    "srcfilenames": [],
    "requires": [],
    "copy_protos_to_genfiles": getattr(ctx.attr, "copy_protos_to_genfiles", False),
    "provides": [],
    "verbose": getattr(ctx.attr, "verbose", True),
    "with_grpc": getattr(ctx.attr, "with_grpc", False),
    "transitive_imports": [],
    "transitive_packages": {},
    "transitive_requires": [],
    "transitive_srcs": [],
  }

  # Propogate proto deps:
  for dep in ctx.attr.proto_deps:
    self["transitive_imports"] += dep.proto.transitive_imports
    self["transitive_packages"] += dep.proto.transitive_packages
    self["transitive_requires"] += dep.proto.transitive_requires
    self["transitive_srcs"] += dep.proto.transitive_srcs

  # Copy source files over to outdir
  _build_source_files(ctx, self)

  # Make a list of languages that were specified for this run
  spec = []
  for name, lang in CLASSES.items():
    #print("gen_%s? %s" % (name, getattr(ctx.attr, "gen_" + name, False)))
    if getattr(ctx.attr, "gen_" + name, False):
      spec += [lang]

  # Prepreprocessing for all requested languages.
  for lang in spec:
    # First language in spec builds the source files.  Kinda hacky.

    invoke("build_generated_files", lang, self)
    invoke("build_imports", lang, self)
    invoke("build_protobuf_invocation", lang, self)
    invoke("build_protobuf_out", lang, self)
    if self["with_grpc"]:
      invoke("build_grpc_invocation", lang, self)
      invoke("build_grpc_out", lang, self)
    invoke("build_inputs", lang, self)

  # Run protoc
  _execute_rule(self)

  # Postprocessing for all requested languages.
  for lang in spec:
    invoke("post_execute", lang, self)

  self["packages"] = {
    ctx.label.package + ':' + ctx.label.name: self["srcs"],
  }

  return struct(
    files=set(self["provides"]),
    proto=struct(

      imports = self["imports"],
      packages = self["packages"],
      srcs = set(self["srcs"]),
      requires = self["requires"],

      transitive_requires = self["requires"] + self["transitive_requires"],
      transitive_imports = self["imports"] + self["transitive_imports"],
      transitive_packages = self["packages"] + self["transitive_packages"],
      transitive_srcs = self["srcs"] + self["transitive_srcs"],
    ),
  )


def implement(spec):

  attrs = {}
  outputs = {}

  self = {
    "attrs": attrs,
    "outputs": outputs,
    "output_to_genfiles": False,
  }

  attrs["verbose"] = attr.int()

  # The protoc executable (built from source by default)
  attrs["protoc"] = attr.label(
    default = Label("//external:protoc"),
    # TODO(pcj): isn't HOST_CFG deprecated?
    cfg = HOST_CFG,
    executable = True,
  )

  # The set of files to compile.  This is actually exposed by the
  # macros as 'srcs'.  TODO(pcj): clean this up.
  attrs["protos"] = attr.label_list(
    allow_files = FileType([".proto"]),
  )

  # *_proto_{compile,library} rule dependencies.
  attrs["proto_deps"] = attr.label_list(providers = ["proto"])

  # Options to be passed to protoc as --proto_path.
  attrs["imports"] = attr.string_list()

  # Flag that sets gen_grpc_{lang} to true for all languages.
  attrs["with_grpc"] = attr.bool()

  # Implementation detail that varies between output languages.
  attrs["copy_protos_to_genfiles"] = attr.bool()

  # Support for genrule implementation that I'd like to deprecate.
  attrs["outs"] = attr.output_list()

  # Generate the descriptor? TOOD(pcj): Why not just always generate this?
  #attrs["with_descriptor"] = attr.bool()

  # Support for protoc plugins not defined in this project.
  # Note: not implemented yet. TODO(pcj): implement this.
  attrs["plugin_name"] = attr.string()
  attrs["plugin_args"] = attr.string_list()
  attrs["plugin_binary"] = attr.string_list()
  attrs["plugin_generated_file_extension"] = attr.string_list()

  # Add attributes foreach language.
  for name in spec:
    lang = CLASSES.get(name)
    if not lang: fail("Language not defined: %s" % name)
    invoke("implement_compile_attributes", lang, self)
    invoke("implement_compile_outputs", lang, self)
    invoke("implement_compile_output_to_genfiles", lang, self)

  # Flag to place generated files in bazel-genfiles.  cpp requires
  # genfiles, everyone else not.
  attrs["output_to_genfiles"] = attr.bool(
    default = self["output_to_genfiles"],
  )

  # Flag to place generated files in the bazel workspace.  May violate sandbox constraints.
  attrs["output_to_workspace"] = attr.bool(
    default = False,
  )

  return rule(
    implementation = _protoc_rule_impl,
    attrs = self["attrs"],
    outputs = self["outputs"],
    output_to_genfiles = self["output_to_genfiles"],
  )
