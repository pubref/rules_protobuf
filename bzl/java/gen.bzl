def pre(ctx, gen_dir, args, srcs, requires, provides):
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

    for src in ctx.files.srcs:
      args += ["--proto_path=" + src.dirname]
      srcs += [src.path]
      requires += [src]

  if (ctx.attr.verbose):
    print("Compiling protobuf java sources into " + protojar.path)

  return (args, srcs, requires, provides)

def post(ctx, requires, provides):
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
