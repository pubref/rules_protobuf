package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_test")
load("//bzl:go/rules.bzl", "go_proto_library", "go_proto_compile")
load("//bzl:go/class.bzl", GO = "CLASS")

go_proto_compile(
    name = "protos",
    protos = ["//examples/helloworld/proto:helloworld.proto"],
    gen_grpc_go = True,
    verbose = 1,
)

go_test(
    name = "client_test",
    srcs = [
        "test.go",
    ],
    deps = [
        "//examples/helloworld/proto:go",
    ] + GO.grpc.compile_deps,
)

go_binary(
    name = "client",
    srcs = [
        "main.go",
    ],
    deps = [
        "//examples/helloworld/proto:go",
    ] + GO.grpc.compile_deps,
)
