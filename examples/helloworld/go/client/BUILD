package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load("//bzl:go/class.bzl", GO = "CLASS")

go_binary(
    name = "client",
    srcs = ["main.go"],
    deps = ["//examples/helloworld/proto:go"] + GO.grpc.compile_deps,
)
