load("//bzl:protoc.bzl", "protoc_genrule", "implement")
load("//bzl:grpc_gateway/class.bzl", GRPC_GATEWAY = "CLASS")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

grpc_gateway_proto_compile = implement(["grpc_gateway"])

def grpc_gateway_proto_library(
    name,
    protos,
    lang = GRPC_GATEWAY,
    srcs = [],
    imports = [],
    visibility = None,
    testonly = 0,
    protoc = None,
    protobuf_plugin = None,
    verbose = 0,
    **kwargs):

  result = protoc_genrule(
    spec = [lang],
    name = name + "_pb_gw",
    protos = protos,
    protoc = protoc,
    protobuf_plugin = protobuf_plugin,
    visibility = visibility,
    testonly = testonly,
    imports = imports,
    with_grpc = True,
    verbose = verbose,
  )

  deps = [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]

  go_library(
    name = name,
    srcs = result.outs,
    deps = deps,
    **kwargs
  )
