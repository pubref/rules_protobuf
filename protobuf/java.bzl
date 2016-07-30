"""Utilities for building Java Protocol Buffers.
"""

def collect_proto_sources(ctx):
  source_files = set(order="compile")
  for dep in ctx.attr.deps:
    source_files += dep.proto_src
  source_files += [ctx.file.src]
  return source_files

def _protobuf_java_library_impl(ctx):
  # You may use print for debugging.

  proto_srcs = collect_proto_sources(ctx)
  inputs, outputs, arguments = list(proto_srcs), [], []

  jar_basename = ctx.outputs.java_src.basename[:-7]

  #print("protobuf jar basename: %s" % jar_basename)

  # Create .jar file base on .srcjar file name
  protojar = ctx.new_file("%s.jar" % jar_basename)
  srcjar = ctx.new_file("%s.srcjar" % jar_basename)
  outputs += [protojar]
  arguments += ["--java_out=" + protojar.path]

  print("Generating protobuf library " + srcjar.path)
  #print("protobuf protojar: %s" % protojar)
  #print("protobuf srcjar: %s" % srcjar)

  ctx.action(
    mnemonic = "GenProto",
    inputs = inputs,
    outputs = outputs,
    arguments = arguments + [ctx.file.src.path],
    executable = ctx.executable.protoc)

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
    "deps": attr.label_list(
      allow_files = False,
      providers = ["proto_src"],
    ),
    "protoc": attr.label(
      default = Label("//third_party/protobuf:protoc_bin"),
      cfg = HOST_CFG,
      executable = True,
    ),
  },
  output_to_genfiles=True,
)
