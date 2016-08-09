load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load("//bzl:go/class.bzl", GO = "CLASS")

go_binary(
    name = "server",
    srcs = [
        "main.go",
    ],
    deps = [
        "//examples/helloworld/proto:go",
    ] + GO.grpc.compile_deps,
)
