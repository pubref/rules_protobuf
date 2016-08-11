load("//bzl:protoc.bzl", "EXECUTABLE", "implement")
load("//bzl:java/class.bzl", JAVA = "CLASS")

java_proto_compile = implement(["java"])

def java_proto_library(
    name,
    protos,
    lang = JAVA,
    proto_compile = java_proto_compile,
    srcs = [],
    includes = [],
    visibility = None,
    testonly = 0,
    protoc = EXECUTABLE,
    protobuf_plugin_options = [],
    protobuf_plugin = None,
    grpc_plugin = None,
    grpc_plugin_options = [],
    verbose = 0,
    with_grpc = False,
    deps = [],
    **kwargs):

  args = {}
  args["name"] = name + "_pb"
  args["deps"] = deps
  args["protos"] = protos
  args["verbose"] = verbose
  args["includes"] = includes
  args["protoc"] = protoc
  args["with_grpc"] = with_grpc
  args["gen_" + lang.name] = True
  args["gen_grpc_" + lang.name] = with_grpc
  args["gen_protobuf_" + lang.name + "_plugin"] = protobuf_plugin
  args["gen_" + lang.name + "_plugin_options"] = protobuf_plugin_options
  args["gen_grpc_" + lang.name + "_plugin"] = grpc_plugin

  proto_compile(**args)

  if with_grpc and hasattr(lang, "grpc"):
    deps += [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]
  elif hasattr(lang, "protobuf"):
    deps += [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]

  native.java_library(
    name = name,
    srcs = srcs + [name + "_pb.srcjar"],
    deps = deps,
    **kwargs
  )
