load("//bzl:util.bzl", "invoke")
load("//bzl:classes.bzl", "CLASSES")


EXECUTABLE = Label("@com_github_google_protobuf//:protoc")


def _execute_genrule(self):
  if self["verbose"]:
    print("COMMAND:\n%s" % "\n".join(self["cmd"]));
    if self["verbose"] > 1:
      print("SRCS: %s" % self["protos"]);
      print("OUTS: %s" % self["outs"]);
      print("TOOLS: %s" % self["tools"]);

  native.genrule(
    name = self["name"],
    srcs = self["protos"],
    testonly = self["testonly"],
    visibility = self["visibility"],
    message = "Generating Protocol Buffer File(s)",
    outs = self["outs"],
    tools = self["tools"],
    cmd = " ".join(self["cmd"]),
  )


def protoc_genrule(name,
                   spec = [],
                   self = {},
                   #gendir = "$(BINDIR)", Note: It *has* to be GENDIR for some reason.
                   outdir = "$(GENDIR)",
                   protos = [],
                   paths = [],
                   protoc=EXECUTABLE,
                   protobuf_plugin=None,
                   protobuf_plugin_options=[],
                   grpc_plugin=None,
                   grpc_plugin_options=[],
                   imports = [],
                   args = [],
                   testonly = False,
                   visibility = None,
                   with_grpc = False,
                   verbose = False,
                   descriptor_set = None,
                   execute = True):

  if protoc == None:
    protoc = EXECUTABLE

  self += {
    "name": name,
    "ctx": None,
    "gendir": outdir,
    "outdir": outdir,
    "protos": protos,
    "paths": paths,
    "protoc": protoc,
    "protobuf_plugin": protobuf_plugin,
    "protobuf_plugin_options": protobuf_plugin_options,
    "grpc_plugin": grpc_plugin,
    "grpc_plugin_options": grpc_plugin_options,
    "imports": imports,
    "testonly": testonly,
    "visibility": visibility,
    "args": args,
    "with_grpc": with_grpc,
    "descriptor_set": descriptor_set,
    "tools": [],
    "cmd": [],
    "outs": [],
    "hdrs": [],
    "verbose": verbose,
    "execute": execute,
  }

  for lang in spec:
    if self["with_grpc"] and not hasattr(lang, "grpc"):
      fail("Language %s does not support gRPC" % lang.name)

    invoke("build_generated_filenames", lang, self)
    invoke("build_tools", lang, self)
    invoke("build_paths", lang, self)
    invoke("build_protobuf_invocation", lang, self)
    invoke("build_protobuf_out", lang, self)
    if with_grpc:
      invoke("build_grpc_invocation", lang, self)
      invoke("build_grpc_out", lang, self)
    invoke("build_protoc_command", lang, self)

  if execute:
    _execute_genrule(self)

  for src in self["outs"]:
    if src.endswith(".h"):
      self["hdrs"] = [src]

  return struct(**self)


def _get_gendir(ctx):
  if ctx.attr.output_to_genfiles:
    return ctx.var["GENDIR"]
  else:
    return ctx.var["BINDIR"]


def _execute_rule(self):
  ctx = self["ctx"]
  if ctx == None:
      fail("Bazel context required for rule execution")

  srcfiles = []
  for src in self["srcfilenames"]:
    srcfiles += [src]
    #srcfiles += [src.path]

  #self["args"] += ["--descriptor_set_out=%s" % (descriptor_set_file.path)]

  arglist = list(set(self["args"]))
  pathlist = ["--proto_path=" + i for i in set(self["paths"])]

  arguments = arglist + pathlist + srcfiles
  inputs = list(set(self["requires"]))
  outputs = list(set(self["provides"] + ctx.outputs.outs))

  if ctx.attr.verbose:
    print("protoc binary: " + ctx.executable.protoc.path)
    for i in range(len(arguments)):
      print(" > arg%s: %s" % (i, arguments[i]))
    for i in inputs:
      print(" > input: %s" % i)
    for o in outputs:
      print(" > output: %s" % o)

  ctx.action(
      mnemonic="ProtoCompile",
      executable=ctx.executable.protoc,
      arguments=arguments,
      inputs=inputs,
      outputs=outputs,
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
        print("Copying %s .. %s" % (srcfile.path, protofile.path))
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

  # This is the key to enable imports: protoc can see the entire
  # source tree from the workspace root.
  self["paths"] += ["."]

def _protoc_rule_impl(ctx):

  gendir = _get_gendir(ctx)
  outdir = gendir
  #outdir = gendir + "/" + ctx.label.package

  self = {
    "ctx": ctx,
    "gendir": gendir,
    "outdir": outdir,
    "imports": [],
    "paths": [],
    "args": [],
    "srcs": [],
    "srcfilenames": [],
    "requires": [],
    "copy_protos_to_genfiles": getattr(ctx.attr, "copy_protos_to_genfiles", False),
    "provides": [],
    "verbose": getattr(ctx.attr, "verbose", True),
    "with_grpc": getattr(ctx.attr, "with_grpc", False),
    #"descriptor_set_file": descriptor_set_file,
    "transitive_imports": [],
    "transitive_paths": [],
    "transitive_packages": {},
    "transitive_requires": [],
    "transitive_srcs": [],
  }

  # Propogate proto deps:
  for dep in ctx.attr.proto_deps:
    print("ctx.attr dep: %s" % dir(dep))
    self["transitive_imports"] += dep.proto.transitive_imports
    self["transitive_paths"] += dep.proto.transitive_paths
    self["transitive_packages"] += dep.proto.transitive_packages
    self["transitive_requires"] += dep.proto.transitive_requires
    self["transitive_srcs"] += dep.proto.transitive_srcs

  # Copy source files over to outdir
  _build_source_files(ctx, self)

  # Make a list of languages that were specified for this run
  spec = []
  for name, lang in CLASSES.items():
    if getattr(ctx.attr, "gen_" + name, False):
      spec += [lang]

  # Prepreprocessing for all requested languages.
  for lang in spec:
    # First language in spec builds the source files.  Kinda hacky.

    invoke("build_generated_files", lang, self)
    invoke("build_imports", lang, self)
    invoke("build_paths", lang, self)
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
      paths = self["paths"],
      packages = self["packages"],
      srcs = set(self["srcs"]),
      requires = self["requires"],

      transitive_requires = self["requires"] + self["transitive_requires"],
      transitive_imports = self["imports"] + self["transitive_imports"],
      transitive_paths = self["paths"] + self["transitive_paths"],
      transitive_packages = self["packages"] + self["transitive_packages"],
      transitive_srcs = self["srcs"] + self["transitive_srcs"],
    ),
  )


def implement(spec):

  attrs = {}

  outputs = {
    #"proto": "%{name}.proto",
  }

  # Language descriptor has an opportunity to override this.
  output_to_genfiles = False

  attrs["verbose"] = attr.int(
    default = 0,
  )

  # The set of files to compile
  attrs["protos"] = attr.label_list(
    allow_files = FileType([".proto"]),
  )

  #attrs["deps"] = attr.label_list(providers = ["proto"])
  attrs["deps"] = attr.label_list()

  attrs["proto_deps"] = attr.label_list(providers = ["proto"])

  # Options to be passed to protoc as --proto_path.  Differs from
  # imports in that these are raw strings rather than labels.
  attrs["paths"] = attr.string_list()

  # Protos that should be made available for proto imports.  These are
  # not added as options but rather copied over to the sandbox where
  # protoc is run, making them available for import. TODO: is this
  # really needed?  Test it by using the descriptor protos from
  # google/protobuf.
  attrs["imports"] = attr.label_list(
    allow_files = FileType([".proto"]),
  )

  # The list of files the rule generates.  How is this actually being
  # used?
  attrs["outs"] = attr.output_list()

  # The protoc executable (built from source by default)
  attrs["protoc"] = attr.label(
    default = Label("//external:protoc"),
    # TODO: isn't HOST_CFG deprecated?
    cfg = HOST_CFG,
    executable = True,
  )

  # Support for protoc plugins not defined here.
  attrs["plugin_name"] = attr.string()
  attrs["plugin_args"] = attr.string_list()
  attrs["plugin_binary"] = attr.string_list()
  attrs["plugin_generated_file_extension"] = attr.string_list()

  # Generate the descriptor? Shouldn't we just always generate this?
  #attrs["with_descriptor"] = attr.bool()

  # Implementation detail that varies between output languages.
  attrs["copy_protos_to_genfiles"] = attr.bool(
    default = False,
  )

  # Flag that sets gen_grpc_{lang} to true for all languages.
  attrs["with_grpc"] = attr.bool()

  # ================================================================
  # Flags for registered languages
  # ================================================================

  # Add (for example) "gen_java = False" and "gen_java_options=[]"
  # foreach language.  If the lang descriptor has a "plugin_binary
  # attribute", add that in.
  for name in spec:
    lang = CLASSES.get(name)
    index = spec.index(name)
    if not lang: fail("Language not defined: %s" % name)

    # Add "gen_java = X" option where X is True if this is the first language specified.
    flag = "gen_" + name
    attrs[flag] = attr.bool(
        default = (index == 0),
    )

    output_to_genfiles = getattr(lang, "output_to_genfiles", output_to_genfiles)

    # Add a "gen_java_plugin_options=[]".
    opts = flag + "_plugin_options"
    attrs[opts] = attr.string_list()

    # If there is a plugin binary, create this label now.
    if hasattr(lang, "protobuf"):
      if hasattr(lang.protobuf, "executable"):
        attrs["gen_protobuf_" + name + "_plugin"] = attr.label(
          default = Label(lang.protobuf.executable),
          cfg = HOST_CFG,
          executable = True,
        )
      if hasattr(lang.protobuf, "outputs"):
        outputs += lang.protobuf.outputs

    # If this language supports gRPC, add this boolean flag in.
    # However, if we didn't load grpc, we don't actually want to
    # generate the label for the executable lest we actually need to
    # have the executable available.  TODO: figure out how to write a
    # variable in the loading phase of workspace and read it here.

    if hasattr(lang, "grpc"):
      attrs["gen_grpc_" + name] = attr.bool()
      if hasattr(lang.grpc, "executable"):
        attrs["gen_grpc_" + name + "_plugin"] = attr.label(
          default = Label(lang.grpc.executable),
          cfg = HOST_CFG,
          executable = True,
        )
      if hasattr(lang.grpc, "outputs"):
        outputs += lang.grpc.outputs


  # Flag that sets gen_grpc_{lang} to true for all languages.
  attrs["output_to_genfiles"] = attr.bool(
    default = output_to_genfiles,
  )

  # Get the go_prefox
  attrs["go_prefix"] = attr.label(
    providers = ["go_prefix"],
    default = Label(
      "//:go_prefix",
      relative_to_caller_repository = True,
    ),
    allow_files = False,
    cfg = HOST_CFG,
  )

  return rule(
    implementation = _protoc_rule_impl,
    attrs = attrs,
    outputs = outputs,
    output_to_genfiles = output_to_genfiles,
  )
