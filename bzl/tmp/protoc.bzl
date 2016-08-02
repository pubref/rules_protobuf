load("//bzl:gen_java.bzl", "gen_java_pre", "gen_java_post")
load("//bzl:gen_go.bzl",   "gen_go_pre",   "gen_go_post")
load("//bzl:gen_py.bzl",   "gen_py_pre",   "gen_py_post")

def protoc_attrs():
  """Returns: a map of rule attributes
  """
  attrs = {}

  attrs["verbose"] = attr.bool()

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

  attrs["gen_java"] = attr.bool()
  attrs["gen_java_options"] = attr.string_list()

  attrs["gen_cpp"] = attr.bool()
  attrs["gen_cpp_options"] = attr.string_list()

  attrs["gen_py"] = attr.bool()
  attrs["gen_py_options"] = attr.string_list()

  attrs["gen_js"] = attr.bool()
  attrs["gen_js_options"] = attr.string_list()

  attrs["gen_go"] = attr.bool()
  attrs["gen_go_options"] = attr.string_list()

  # Flag that should be implemented by each language gen option
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

# ================================================================
# Implementation
# ================================================================

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

def protoc_impl(ctx):
  """General implementation for generating protos
  """
  args = []
  requires = []
  provides = []
  import_flags = []
  gen_dir = _GenDir(ctx)

  srcs = ctx.files.srcs
  requires += ctx.files.srcs
  if gen_dir:
    import_flags += ["-I" + gen_dir, "-I" + ctx.var["GENDIR"] + "/" + gen_dir]
  else:
    import_flags += ["-I."]

  for dep in ctx.attr.deps:
    import_flags += dep.proto.import_flags
    requires += dep.proto.deps

  # ################################################################
  # Per-language Setup and Preprocessing
  #
  if (ctx.attr.gen_go):
    args, requires, provides = gen_go_pre(ctx, gen_dir, args, requires, provides)
  if (ctx.attr.gen_java):
    args, requires, provides = gen_java_pre(ctx, gen_dir, args, requires, provides)
  if (ctx.attr.gen_py):
    args, requires, provides = gen_py_pre(ctx, gen_dir, args, requires, provides)

  # ################################################################
  # Execute protoc
  #
  arguments = args + import_flags + [src.path for src in srcs]
  inputs = list(set(requires))
  outputs = ctx.outputs.outs + provides

  if (ctx.attr.verbose):
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

  # ################################################################
  # Postprocessing
  #
  if (ctx.attr.gen_go):
    requires, provides = gen_go_post(ctx, requires, provides)
  if (ctx.attr.gen_java):
    requires, provides = gen_java_post(ctx, requires, provides)
  if (ctx.attr.gen_py):
    requires, provides = gen_py_post(ctx, requires, provides)

  return struct(
    files=set(provides),
    proto=struct(
      srcs=srcs,
      import_flags=import_flags,
      deps=requires,
    ),
  )


# ****************************************************************
# Build Rules
# ****************************************************************

protoc = rule(
  implementation=protoc_impl,
  attrs=protoc_attrs(),
  output_to_genfiles=True,
)

# ****************************************************************
# External Dependencies
# ****************************************************************

def rules_protobuf_protoc(
  omit_protoc_linux_x86_64=False,
  omit_protoc_macosx=False):

  if not omit_protoc_linux_x86_64:
    protoc_linux_x86_64()
  if not omit_protoc_macosx:
    protoc_macosx()


def protoc_linux_x86_64():
  native.http_file(
      name = "protoc_linux_x86_64",
      url = "http://repo1.maven.org/maven2/com/google/protobuf/protoc/3.0.0/protoc-3.0.0-linux-x86_64.exe",
      sha256 = "98e235228b70e747ac850f1411d1d5de351c2dc3227a4086b1d940b5e099257f",
  )


def protoc_macosx():
  native.http_file(
      name = "protoc_macosx",
      url = "http://repo1.maven.org/maven2/com/google/protobuf/protoc/3.0.0/protoc-3.0.0-osx-x86_64.exe",
      sha256 = "d9a1dd45e3eee4a9abfbb4be26172d69bf82018a3ff5b1dff790c58edbfcaf4a",
  )
