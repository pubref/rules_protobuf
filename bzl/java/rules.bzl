load("//bzl:protoc.bzl", "EXECUTABLE", "implement")
load("//bzl:util.bzl", "invoke")
load("//bzl:java/class.bzl", JAVA = "CLASS")

java_proto_compile = implement(["java"])

def java_proto_library(
    name,
    protos,
    lang = JAVA,
    srcs = [],
    imports = [],
    visibility = None,
    testonly = 0,
    protoc_executable = EXECUTABLE,
    protobuf_plugin_options = [],
    protobuf_plugin_executable = None,
    grpc_plugin_executable = None,
    grpc_plugin_options = [],
    descriptor_set = None,
    verbose = True,
    with_grpc = False,
    deps = [],
    **kwargs):

  self = {
    "protos": protos,
    "with_grpc": with_grpc,
  }

  java_proto_compile(
    name = name + "_pb",
    protos = protos,
    gen_java = True,
    deps = deps,
    gen_grpc_java = with_grpc,
    copy_protos_to_genfiles = False,
    protoc = protoc_executable,
  )

  if with_grpc:
    proto_deps = [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]
  else:
    proto_deps = [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]

  native.java_library(
    name = name,
    srcs = srcs + [name + "_pb.srcjar"],
    deps = deps + proto_deps,
    **kwargs
  )
