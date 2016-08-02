load("//bzl:java/gen.bzl",
     gen_java_pre = "pre",
     gen_java_post = "post",
)

load("//bzl:go/gen.bzl",
     gen_go_pre = "pre",
     gen_go_post = "post",
)

load("//bzl:python/gen.bzl",
     gen_python_pre = "pre",
     gen_python_post = "post",
)


LANGUAGES = {
  "java": {
    "pre": gen_java_pre,
    "post": gen_java_post,
  },
  "go": {
    "pre": gen_go_pre,
    "post": gen_go_post,
  },
  "py": {
    "pre": gen_python_pre,
    "post": gen_python_post,
  }
}


def _GetPath(ctx, path):
  if ctx.label.workspace_root:
    return ctx.label.workspace_root + '/' + path
  else:
    return path


def _GenDir(ctx):
  if not ctx.attr.includes:
    return ctx.label.workspace_root
  if not ctx.attr.includes[0]:
    return _GetPath(ctx, ctx.label.package)
  if not ctx.label.package:
    return _GetPath(ctx, ctx.attr.includes[0])
  return _GetPath(ctx, ctx.label.package + '/' + ctx.attr.includes[0])


def attrs():
  """Returns: a map of rule attributes
  """
  attrs = {}

  attrs["verbose"] = attr.int(
    default = 0,
  )

  # The set of files to compile
  attrs["srcs"] = attr.label_list(
    allow_files = FileType([".proto"]),
  )

  # Disclaimer: I dont understand this providers attribute
  attrs["deps"] = attr.label_list(providers = ["proto"])

  # Additional include options to protoc
  attrs["includes"] = attr.string_list()

  # The list of files the rule generates
  attrs["outs"] = attr.output_list()

  # ================================================================
  # Language Flags
  # ================================================================

  for lang in LANGUAGES.keys():
    flag = "gen_" + lang
    opts = flag + "_options"
    attrs[flag] = attr.bool()
    attrs[opts] = attr.string_list()

  attrs["with_grpc"] = attr.bool()

  # ================================================================
  # Binary tool substitution options
  # ================================================================

  attrs["protoc"] = attr.label(
    default = Label("//third_party/protoc:protoc_bin"),
    cfg = HOST_CFG,
    executable = True,
  )

  attrs["protoc_gen_grpc_java"] = attr.label(
    default = Label("//third_party/protoc_gen_grpc_java:protoc_gen_grpc_java_bin"),
    cfg = HOST_CFG,
    executable = True,
  )

  attrs["protoc_gen_go"] = attr.label(
    default = Label("@com_github_golang_protobuf//:protoc_gen_go"),
    cfg = HOST_CFG,
    executable = True,
  )

  # attrs["protoc_gen_python_grpc"] = attr.label(
  #   #default = Label("@com_github_grpc_grpc//:protoc_gen_python_grpc_bin"),
  #   default = Label("@com_github_grpc_grpc//:"),
  #   cfg = HOST_CFG,
  #   executable = True,
  # )

  return attrs


def gen(ctx):
  """General implementation for generating protos
  """
  args = []
  srcs = []
  requires = []
  provides = []
  import_flags = []
  gen_dir = _GenDir(ctx)

  if gen_dir:
    import_flags += ["-I" + gen_dir, "-I" + ctx.var["GENDIR"] + "/" + gen_dir]
  else:
    import_flags += ["-I."]

  for dep in ctx.attr.deps:
    import_flags += dep.proto.import_flags
    requires += dep.proto.deps

  # Per-language Setup and Preprocessing
  #
  for lang, impl in LANGUAGES.items():
    flag = "gen_" + lang
    if getattr(ctx.attr, flag):
      pre = impl["pre"]
      args, srcs, requires, provides = pre(ctx, gen_dir, args, srcs, requires, provides)

  # Run protoc
  #
  #arguments = args + import_flags + [src.path for src in srcs]
  arguments = args + import_flags + [src for src in srcs]
  #arguments = args + import_flags + [srcs] # srcs is a list of strings
  #requires += [srcs]
  inputs = list(set(requires))
  #inputs = requires
  outputs = ctx.outputs.outs + provides

  if ctx.attr.verbose:
    print("protoc binary: " + ctx.executable.protoc.path)
    for i in range(len(arguments)):
      print(" > arg%s: %s" % (i, arguments[i]))
    for i in inputs:
      print(" > input: %s" % i)
    for o in outputs:
      print(" > output: %s" % o)

  if args:
    ctx.action(
        mnemonic="ProtoCompile",
        executable=ctx.executable.protoc,
        arguments=arguments,
        inputs=inputs,
        outputs=outputs,
    )

  # Postprocessing
  #
  for lang, impl in LANGUAGES.items():
    flag = "gen_" + lang
    if getattr(ctx.attr, flag):
      post = impl["post"]
      requires, provides = post(ctx, requires, provides)

  return struct(
    files=set(provides),
    proto=struct(
      srcs=srcs,
      import_flags=import_flags,
      deps=requires,
    ),
  )
