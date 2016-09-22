package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("//go:rules.bzl", "GRPC_COMPILE_DEPS")

go_binary(
    name = "server",
    srcs = ["main.go"],
    deps = ["//examples/helloworld/proto:go"] + GRPC_COMPILE_DEPS,
)

# library used by greeter_test.
go_library(
    name = "greeter",
    srcs = ["main.go"],
    deps = ["//examples/helloworld/proto:go"] + GRPC_COMPILE_DEPS,
)
