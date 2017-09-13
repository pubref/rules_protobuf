package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load(
    "//go:rules.bzl",
    "go_proto_library",
    GO_GRPC_COMPILE_DEPS = "GRPC_COMPILE_DEPS",
)

go_proto_library(
    name = "api_proto",
    importpath = "github.com/my/custom/import/path",
    protos = ["api.proto"],
    with_grpc = True,
)

go_binary(
    name = "client",
    srcs = ["main.go"],
    deps = [
        ":api_proto",
    ] + GO_GRPC_COMPILE_DEPS,
)
