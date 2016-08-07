load("//bzl:languages.bzl", "LANGUAGES")

def implement(spec):
  """Create a protocol buffer compilation rule for the given set of languages.
  """

  attrs = {}
  outputs = {
      #"descriptor_set": "%{name}_descriptor.proto",
  }

  attrs["verbose"] = attr.int(
      default = 0,
  )

  # The set of files to compile
  attrs["srcs"] = attr.label_list(
      allow_files = FileType([".proto"]),
  )

  # ? How to deps interact here?  Don't understand this. Provider
  # aspect is "proto".
  attrs["deps"] = attr.label_list(providers = ["proto"])

  # Additional include options to protoc.  These should be
  # directories.  TODO(user): should this be typed as directory only?
  attrs["includes"] = attr.string_list()

  # The list of files the rule generates.  How is this actually being
  # used?
  attrs["outs"] = attr.output_list()

  # The protoc executable (built from source by default)
  attrs["protoc_exe"] = attr.label(
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

  # # ================================================================
  # # Flags for known languages
  # # ================================================================

  # Add (for example) "gen_java = False" and "gen_java_options=[]"
  # foreach language.  If the lang descriptor has a "plugin_binary
  # attribute", add that in.
  for name in spec:
    lang = LANGUAGES.get(name)
    if not lang: fail("Language not defined: %s" % name)

    # Add "gen_java = True" option
    flag = "gen_" + name
    attrs[flag] = attr.bool(
        default = True,
    )

    # Add a "gen_java_plugin_options=[]".
    opts = flag + "_plugin_options"
    attrs[opts] = attr.string_list()

    # If there is a plugin binary, create this label now.
    if hasattr(lang, "plugin_exe"):
        attrs["gen_" + name + "_plugin_exe"] = attr.label(
            default = Label(lang.plugin_exe),
            cfg = HOST_CFG,
            executable = True,
        )

    # If this language supports gRPC, add this boolean flag in.
    if hasattr(lang, "supports_grpc"):
        attrs["with_grpc"] = attr.bool()

  # ================================================================
  # Binary tool substitution options
  # ================================================================

  # attrs["protoc_gen_grpc_java"] = attr.label(
  #   default = Label("//third_party/protoc_gen_grpc_java:protoc_gen_grpc_java_bin"),
  #   cfg = HOST_CFG,
  #   executable = True,
  # )

  # attrs["protoc_gen_go"] = attr.label(
  #   default = Label("@com_github_golang_protobuf//:protoc_gen_go"),
  #   cfg = HOST_CFG,
  #   executable = True,
  # )

  # attrs["protoc_gen_grpc"] = attr.label(
  #   # Note: the default value here is a cc_binary that expects to find
  #   # //external:protobuf_compiler, so that must be bind'ed.
  #   default = Label("@com_github_grpc_grpc//:grpc_cpp_plugin"),
  #   cfg = HOST_CFG,
  #   executable = True,
  # )

  #print("attrs: %s" % attrs.keys())

  return rule(
    implementation = _execute,
    attrs = attrs,
    outputs = outputs,
    output_to_genfiles = False,
  )


def get_path(ctx, path):
  if ctx.label.workspace_root:
    return ctx.label.workspace_root + '/' + path
  else:
    return path


def get_gendir(ctx):
  return ctx.var["GENDIR"] + "/" + ctx.label.package
  # if not ctx.attr.includes:
  #   return ctx.label.workspace_root
  # if not ctx.attr.includes[0]:
  #   return get_path(ctx, ctx.label.package)
  # if not ctx.label.package:
  #   return get_path(ctx, ctx.attr.includes[0])
  # return get_path(ctx, ctx.label.package + '/' + ctx.attr.includes[0])

def build_imports(ctx, lang, builder):
  pass

    # if gendir:
    #     imports += ["-I" + gendir, "-I" + ctx.var["GENDIR"] + "/" + gendir]
    # else:
    #     imports += ["-I."]
    # return imports


def pre_execute(ctx, lang):
  pass


def post_execute(ctx, lang, builder):
  pass


def build_source_files(ctx, builder):
  # Copy the proto source to the gendir namespace (where the
  # BUILD rule is called)
  for srcfile in ctx.files.srcs:
    protofile = ctx.new_file(builder["descriptor_set_file"], (srcfile.short_path))
    print("Copying %s .. %s" % (srcfile.path, protofile.path))
    ctx.action(
      mnemonic = "CpProtoToPackageGengiles",
      inputs = [srcfile],
      outputs = [protofile],
      arguments = [srcfile.dirname, srcfile.path, protofile.path],
      command = "mkdir -p $1 && cp2 $2 $3")
    builder["imports"] += [srcfile.dirname]
    builder["srcs"] += [protofile]


# Rational default for the generation path is: the GEN_DIR + package path +
def build_protoc_arguments(ctx, lang, builder):
  builder["args"] += ["--%s_out=%s" % (lang.name, ".")]


def build_provided_pb_files(ctx, lang, builder):
    exts = getattr(lang, "pb_file_extensions", [".pb"])
    for srcfile in builder["srcs"]:
      #print("srcfile path: %s" % srcfile.path)
      base = srcfile.basename[:-len(".proto")]
      for ext in exts:
        pbfile = ctx.new_file(srcfile, base + ext)
        builder["provides"] += [pbfile]


def _execute(ctx):
  """Execute protoc for all defined languages.

  """

  gendir = get_gendir(ctx)

  # Make a list of languages that were specified for this run
  spec = []

  # Per-language Setup and Preprocessing
  #
  for name, lang in LANGUAGES.items():
    if getattr(ctx.attr, "gen_" + name):
      spec += [lang]


  imports = []
  args = []
  srcs = []
  requires = []
  provides = []

  # Propogate proto deps
  for dep in ctx.attr.deps:
      imports += dep.proto.imports
      requires += dep.proto.deps

  # Arguments to satisfy the *.descriptor.proto implicit output target
  descriptor_set_filename = ctx.label.name + "_descriptor.proto"
  descriptor_set_file = ctx.new_file(descriptor_set_filename)
  args += ["--descriptor_build_out=%s" % descriptor_set_filename]
  provides += [descriptor_set_file]

  builder = {
    "gendir": gendir,
    "imports": imports,
    "args": args,
    "srcs": srcs,
    "requires": requires,
    "provides": provides,
    "descriptor_set_file": descriptor_set_file,
  }

  build_source_files(ctx, builder)

  # Prepreprocessing for all requested languages.
  for lang in spec:
    _build_imports = getattr(lang, "build_imports", build_imports)
    _build_imports(ctx, lang, builder)

    _build_provided_pb_files = getattr(lang, "build_provided_pb_files", build_provided_pb_files)
    _build_provided_pb_files(ctx, lang, builder)

    _build_protoc_arguments = getattr(lang, "build_protoc_arguments", build_protoc_arguments)
    _build_protoc_arguments(ctx, lang, builder)

  # Run protoc
  #
  arguments = list(set(builder["args"] + ["-I" + i for i in builder["imports"]] + [src.basename for src in builder["srcs"]]))
  inputs = list(set(builder["requires"]))
  outputs = list(set(builder["provides"] + ctx.outputs.outs))

  if ctx.attr.verbose:
    print("protoc binary: " + ctx.executable.protoc_exe.path)
    for i in range(len(arguments)):
      print(" > arg%s: %s" % (i, arguments[i]))
    for i in inputs:
      print(" > input: %s" % i)
    for o in outputs:
      print(" > output: %s" % o)

  ctx.action(
      mnemonic="ProtoCompile",
      executable=ctx.executable.protoc_exe,
      arguments=arguments,
      inputs=inputs,
      outputs=outputs,
  )

  # Postprocessing
  #
  for lang in spec:
    _post_execute = getattr(lang, "post_execute", post_execute)
    _post_execute(ctx, lang, builder)

  return struct(
      files=set(builder["provides"]),
      proto=struct(
          srcs=set(builder["srcs"]),
          imports=builder["imports"],
          deps=builder["requires"],
      ),

  )
