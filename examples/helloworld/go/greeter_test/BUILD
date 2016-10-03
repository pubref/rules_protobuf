package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_test")
load("//go:rules.bzl", "GRPC_COMPILE_DEPS")

go_test(
    name = "greeter_test",
    size = "small",
    srcs = ["greeter_test.go"],
    tags = ["exclusive"],
    deps = [
        "//examples/helloworld/proto:go",
        "//examples/helloworld/go/server:greeter",
    ] + GRPC_COMPILE_DEPS,
)
