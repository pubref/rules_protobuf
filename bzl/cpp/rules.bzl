load("//bzl:protoc.bzl", "implement", "EXECUTABLE")
load("//bzl:util.bzl", "invoke")
load("//bzl:cpp/class.bzl", CPP = "CLASS")

cc_proto_compile = implement(["cpp"])

def cc_proto_library(
    name,
    protos,
    copy_protos_to_genfiles = False,
    deps = [],
    grpc_plugin = None,
    grpc_plugin_options = [],
    imports = [],
    lang = CPP,
    paths = [],
    proto_compile = cc_proto_compile,
    protobuf_plugin_options = [],
    protobuf_plugin = None,
    protoc = EXECUTABLE,
    srcs = [],
    verbose = 0,
    visibility = None,
    with_grpc = False,
    **kwargs):

  args = {}
  args["name"] = name + "_pb"
  args["copy_protos_to_genfiles"] = copy_protos_to_genfiles
  args["deps"] = deps
  args["imports"] = imports
  args["gen_" + lang.name] = True
  args["gen_grpc_" + lang.name] = with_grpc
  args["gen_protobuf_" + lang.name + "_plugin"] = protobuf_plugin
  args["gen_" + lang.name + "_plugin_options"] = protobuf_plugin_options
  args["gen_grpc_" + lang.name + "_plugin"] = grpc_plugin
  args["paths"] = paths
  args["protoc"] = protoc
  args["protos"] = protos
  args["verbose"] = verbose
  args["with_grpc"] = with_grpc

  proto_compile(**args)

  if with_grpc and hasattr(lang, "grpc"):
    proto_deps = [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]
  elif hasattr(lang, "protobuf"):
    proto_deps = [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]

  cc_deps = list(set(deps + proto_deps))

  native.cc_library(
    name = name,
    srcs = srcs + [name + "_pb"],
    deps = cc_deps,
    **kwargs
  )
