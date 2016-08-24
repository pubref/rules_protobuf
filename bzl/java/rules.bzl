load("//bzl:protoc.bzl", "PROTOC", "implement")
load("//bzl:java/class.bzl", JAVA = "CLASS")

java_proto_compile = implement([JAVA.name])

def java_proto_library(
    name,
    copy_protos_to_genfiles = False,
    deps = [],
    grpc_plugin = None,
    grpc_plugin_options = [],
    imports = [],
    lang = JAVA,
    protobuf_plugin_options = [],
    protobuf_plugin = None,
    proto_compile = java_proto_compile,
    proto_deps = [],
    protoc = PROTOC,
    protos = [],
    srcs = [],
    verbose = 0,
    visibility = None,
    with_grpc = False,
    **kwargs):

  args = {}
  args["name"] = name + ".pb"
  args["copy_protos_to_genfiles"] = False
  args["imports"] = imports
  args["gen_" + lang.name] = True
  args["gen_grpc_" + lang.name] = with_grpc
  args["gen_protobuf_" + lang.name + "_plugin"] = protobuf_plugin
  args["gen_" + lang.name + "_plugin_options"] = protobuf_plugin_options
  args["gen_grpc_" + lang.name + "_plugin"] = grpc_plugin
  args["proto_deps"] = [d + "_pb" for d in deps]
  args["protoc"] = protoc
  args["protos"] = protos
  args["verbose"] = verbose
  args["with_grpc"] = with_grpc

  proto_compile(**args)

  if with_grpc and hasattr(lang, "grpc"):
    deps += [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]
  elif hasattr(lang, "protobuf"):
    deps += [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]

  deps = list(set(deps + proto_deps))

  native.java_library(
    name = name,
    srcs = srcs + [name + ".pb.srcjar"],
    deps = deps,
    **kwargs
  )
