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
    hdrs = [],
    **kwargs):

  self = {
    "protos": protos,
    "with_grpc": with_grpc,
    "outs": [name + ".srcjar"],
  }

  #print("self %s" % self)

  java_proto_compile(
    name = name + "_pb",
    protos = protos,
    outs = self["outs"],
    gen_java = True,
    gen_grpc_java = with_grpc,
    copy_protos_to_genfiles = False,
    protoc = protoc_executable,
  )

  java_deps = [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]
  if with_grpc:
    java_deps += [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]

  native.java_library(
    name = name,
    srcs = srcs + self["outs"],
    deps = deps + java_deps,
    **kwargs
  )
