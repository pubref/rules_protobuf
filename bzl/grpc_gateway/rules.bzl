load("@io_bazel_rules_go//go:def.bzl", "go_library", "go_binary")
load("//bzl:base/rules.bzl", "proto_library")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:grpc_gateway/class.bzl", GATEWAY = "CLASS")
load("//bzl:protoc.bzl", "PROTOC", "implement")

SPEC = [GO, GATEWAY]

grpc_gateway_proto_compile = implement(SPEC)

def grpc_gateway_proto_library(
    name,
    alsologtostderr = False,
    go_import_map = {},
    import_prefix = None,
    logtostderr = True,
    log_dir = None,
    log_level = None,
    proto_compile_args = {},
    verbose = 0,
    **kwargs):

  args = {}
  args["go_import_map"] = go_import_map + GATEWAY.default_go_import_map
  args["logtostderr"] = logtostderr
  args["alsologtostderr"] = alsologtostderr
  args["log_dir"] = log_dir
  args["log_level"] = log_level
  args["import_prefix"] = import_prefix
  args["gen_go_grpc"] = True
  args["gen_gateway_grpc"] = True
  args["verbose"] = verbose

  proto_library(name,
                proto_compile = grpc_gateway_proto_compile,
                proto_compile_args = args + proto_compile_args,
                verbose = verbose,
                spec = SPEC,
                **kwargs)


def grpc_gateway_binary(name,
                        srcs = [],
                        deps = [],
                        protos = [],
                        proto_label = "go_default_library",
                        proto_deps = [],
                        **kwargs):

  grpc_gateway_proto_library(
    name = proto_label,
    protos = protos,
    proto_deps = proto_deps,
     **kwargs
  )

  go_binary(
     name = name,
     srcs = srcs,
     deps = deps + [proto_label] + GATEWAY.grpc.compile_deps,
  )
