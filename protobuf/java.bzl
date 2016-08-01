"""Utilities for building Java Protocol Buffers.
"""

def collect_proto_sources(ctx):
  source_files = set(order="compile")
  # for dep in ctx.attr.deps:
  #   source_files += dep.proto_src
  source_files += [ctx.file.src]
  return source_files

def _protobuf_java_library_impl(ctx):
  # You may use print for debugging.
  verbose = ctx.attr.verbose
  proto_srcs = collect_proto_sources(ctx)
  inputs, outputs, arguments = list(proto_srcs), [], []

  # Example: jar_basename of echo.proto is 'echo'
  jar_basename = ctx.outputs.java_src.basename[:-7]
  # Example: protojar is 'echo.jar'
  protojar = ctx.new_file("%s.jar" % jar_basename)
  # Example: srcjar is 'echo.srcjar'
  srcjar = ctx.new_file("%s.srcjar" % jar_basename)

  outputs += [protojar]

  if ctx.attr.with_grpc_plugin:
    protoc_gen_grpc_java = ctx.executable._protoc_gen_grpc_java
    proto_path = ctx.file.src.dirname
    inputs += [protoc_gen_grpc_java]
    # Generates the service stub classes
    arguments += [
      "--plugin=protoc-gen-grpc-java=" + protoc_gen_grpc_java.path,
      "--grpc-java_out=" + protojar.path,
      "--proto_path=" + proto_path,
    ]

  # Generates the typical protobuf message classes
  arguments += ["--java_out=" + protojar.path]

  if (verbose):
    print("Generating protobuf sources in " + srcjar.path)
    print("  protoc command arguments: %s" % arguments )

  ctx.action(
    mnemonic = "GenProto",
    inputs = inputs,
    outputs = outputs,
    arguments = arguments + [ctx.file.src.path],
    executable = ctx.executable._protoc)

  # This is required because protoc only understands .jar extensions, but Bazel
  # requires source JAR files end in .srcjar.
  ctx.action(
    mnemonic = "FixProtoSrcJar",
    inputs = [protojar],
    outputs = [srcjar],
    arguments = [protojar.path, srcjar.path],
    command = "cp $1 $2")

  # Fixup the resulting outputs to keep the source-only .jar out of the result.
  outputs += [srcjar]
  outputs = [e for e in outputs if e != protojar]

  return struct(files=set(outputs),
                proto_src=proto_srcs)

protobuf_java_library = rule(
  implementation=_protobuf_java_library_impl,
  outputs = {
    "java_src": "%{src}.srcjar",
  },
  attrs = {
    "src": attr.label(
      allow_files = FileType([".proto"]),
      mandatory = True,
      single_file = True,
    ),
    # "deps": attr.label_list(
    #   allow_files = False,
    #   providers = ["proto_src"],
    # ),
    "with_grpc_plugin": attr.bool(),
    "verbose": attr.bool(),
    "_protoc": attr.label(
      default = Label("//third_party/protobuf:protoc_bin"),
      cfg = HOST_CFG,
      executable = True,
    ),
    "_protoc_gen_grpc_java": attr.label(
      default = Label("//third_party/protobuf:protoc_gen_grpc_java_bin"),
      cfg = HOST_CFG,
      executable = True,
    ),
  },
  output_to_genfiles=True,
)
