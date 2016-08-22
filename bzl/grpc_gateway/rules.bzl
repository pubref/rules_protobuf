load("//bzl:protoc.bzl", "EXECUTABLE", "implement")
load("//bzl:grpc_gateway/class.bzl", GRPC_GATEWAY = "CLASS")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

grpc_gateway_proto_compile = implement(["go", "gateway"])

def grpc_gateway_proto_library(
    name,
    protos,
    copy_protos_to_genfiles = True,
    deps = [],
    grpc_plugin = None,
    grpc_plugin_options = [],
    imports = [],
    lang = GRPC_GATEWAY,
    proto_compile = grpc_gateway_proto_compile,
    protobuf_plugin_options = [],
    protobuf_plugin = None,
    protoc = EXECUTABLE,
    srcs = [],
    verbose = 0,
    visibility = None,
    **kwargs):

  args = {}
  args["name"] = name + "_pb_gw"
  args["copy_protos_to_genfiles"] = copy_protos_to_genfiles
  args["deps"] = deps
  args["imports"] = imports
  args["gen_grpc_gateway"] = True
  args["gen_protobuf_go_plugin"] = protobuf_plugin
  args["gen_go_plugin_options"] = protobuf_plugin_options
  #args["gen_grpc_" + lang.name + "_plugin"] = grpc_plugin
  args["protoc"] = protoc
  args["protos"] = protos
  args["verbose"] = verbose
  args["with_grpc"] = True

  proto_compile(**args)

  proto_deps = [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]

  grpc_gateway_deps = list(set(deps + proto_deps))

  go_library(
     name = name,
     srcs = srcs + [name + "_pb_gw"],
     deps = grpc_gateway_deps,
     **kwargs
  )

# grpc_gateway_proto_compile = implement(["grpc_gateway"])

# def grpc_gateway_proto_library(
#     name,
#     protos,
#     lang = GRPC_GATEWAY,
#     srcs = [],
#     imports = [],
#     visibility = None,
#     testonly = 0,
#     protoc = None,
#     protobuf_plugin = None,
#     verbose = 0,
#     **kwargs):

#   result = protoc_genrule(
#     spec = [lang],
#     name = name + "_pb_gw",
#     protos = protos,
#     protoc = protoc,
#     protobuf_plugin = protobuf_plugin,
#     visibility = visibility,
#     testonly = testonly,
#     imports = imports,
#     with_grpc = True,
#     verbose = verbose,
#   )

#   deps = [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]

#   go_library(
#     name = name,
#     srcs = result.outs,
#     deps = deps,
#     **kwargs
#   )
