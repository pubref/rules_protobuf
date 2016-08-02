# Copied a part of protobuf.bzl from github.com/google/protobuf.
# Locally modified.

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

  return attrs

# ================================================================
# Utilities
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

# def _protoc_gen_cpp_pre(ctx, gen_dir, args, deps):
#   """Configure arguments for cpp generation
#   """
#   args += ["--cpp_out=" + ctx.var["GENDIR"] + "/" + gen_dir]
#   return (args, deps)

# def _protoc_gen_py_pre(ctx, gen_dir, args, deps):
#   """Configure arguments for python generation
#   """
#   args += ["--python_out=" + ctx.var["GENDIR"] + "/" + gen_dir]
#   return (args, deps)


# ================================================================
# Java Customization
# ================================================================

def _protoc_gen_java_pre(ctx, gen_dir, args, requires, provides):
  """Configure arguments for java generation
  """
  # Example: protojar is 'echo.jar', srcjar is 'echo.srcjar'
  jar_basename = ctx.outputs.java_src.basename[:-len(".srcjar")]
  protojar = ctx.new_file("%s.jar" % jar_basename)
  provides += [protojar]

  args += ["--java_out=" + protojar.path]

  if ctx.attr.with_grpc:
    protoc_gen_grpc_java = ctx.executable.protoc_gen_grpc_java
    requires += [protoc_gen_grpc_java]
    args += [
      "--plugin=protoc-gen-grpc-java=" + protoc_gen_grpc_java.path,
      "--grpc-java_out=" + protojar.path,
    ]

    for e in ctx.files.srcs:
      args += ["--proto_path=" + e.dirname]

  if (ctx.attr.verbose):
    print("Compiling protobuf java sources into " + protojar.path)

  return (args, requires, provides)

def _protoc_gen_java_post(ctx, requires, provides):
  """Post processing for java
  """
  jar_basename = ctx.outputs.java_src.basename[:-7]
  protojar = ctx.new_file("%s.jar" % jar_basename)
  srcjar = ctx.new_file("%s.srcjar" % jar_basename)

  # Rename protojar to srcjar so that rules like java_library can
  # consume it.
  ctx.action(
    mnemonic = "FixProtoSrcJar",
    inputs = [protojar],
    outputs = [srcjar],
    arguments = [protojar.path, srcjar.path],
    command = "cp $1 $2")

  # Remove protojar from the list of provided outputs
  provides = [e for e in provides if e != protojar]

  provides += [srcjar]

  if (ctx.attr.verbose):
    print("Compiled protobuf java srcjar " + srcjar.path)

  return (requires, provides)

# ================================================================
# Go Customization
# ================================================================

def _protoc_gen_go_pre(ctx, gen_dir, args, requires, provides):
  """Configure arguments for go generation
  """
  go_dir = ctx.var["GENDIR"] + "/" + gen_dir

  # **************** Args ****************

  protoc_gen_go = ctx.executable.protoc_gen_go
  args += ["--plugin=protoc-gen-go=" + protoc_gen_go.path]

  go_out = go_dir
  go_opts = [] + ctx.attr.gen_go_options
  import_map = {} + ctx.attr.import_map
  print("import_map: %s" % import_map)
  for (srcfilename, import_prefix) in import_map.items():
    go_opts += ["M" + srcfilename + "=" + import_prefix]
  if (ctx.attr.with_grpc):
    go_opts += ["grpc"]
  if go_opts:
    go_out = ",".join(go_opts) + ":" + go_out

  args += ["--go_out=" + go_out]

  #args += ["--descriptor_set_out=" + ctx.outputs.descriptor.path]

  # **************** Requires ****************

  requires += [protoc_gen_go]

  # **************** Provides ****************

  for srcfile in ctx.files.srcs:
    if not srcfile.path.endswith('.proto'):
      fail("non proto source file %s" % str(srcfile), "srcs")

    basename = srcfile.basename
    filename = basename[:-len('.proto')] + ".pb.go"
    protofile = ctx.new_file(basename)
    gofile = ctx.new_file(filename)

    # Copy the proto source to the context namespace (where the BUILD
    # rule is called) to better support imports (necessary).
    ctx.action(
      mnemonic = "RebaseSrc",
      inputs = [srcfile],
      outputs = [protofile],
      arguments = [srcfile.path, protofile.path],
      command = "cp $1 $2")

    requires += [protofile]
    provides += [gofile]

  return (args, requires, provides)

def _protoc_gen_go_post(ctx, requires, provides):
  """Post processing for go
  """
  return (requires, provides)

# ****************************************************************
# Build Rule (support)
# ****************************************************************

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

  if (ctx.attr.gen_java):
    args, requires, provides = _protoc_gen_java_pre(ctx, gen_dir, args, requires, provides)
  if (ctx.attr.gen_go):
    args, requires, provides = _protoc_gen_go_pre(ctx, gen_dir, args, requires, provides)

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

  if (ctx.attr.gen_java):
    requires, provides = _protoc_gen_java_post(ctx, requires, provides)
  if (ctx.attr.gen_go):
    requires, provides = _protoc_gen_go_post(ctx, requires, provides)

  files = set(provides)

  if (ctx.attr.verbose):
    print("protoc_gen provided files: %s" % str(files))

  return struct(
    files=files,
    proto=struct(
      srcs=srcs,
      import_flags=import_flags,
      deps=requires,
    ),
  )

protoc = rule(
  implementation=protoc_impl,
  attrs=protoc_attrs(),
  output_to_genfiles=True,
)

# ****************************************************************
# Workspace Dependency Management
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
