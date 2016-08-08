package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary")

load("//bzl:protobuf.bzl", "proto_compile")
load("//bzl:go/rules.bzl", "go_proto_library")

go_binary(
    name = "client",
    srcs = [
        "main.go",
    ],
    deps = [
        #":protolib",
        # "//examples/helloworld/go/helloworld",
        "@com_github_golang_glog//:go_default_library",
        "@com_github_golang_protobuf//:proto",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//:context",
    ],
)


proto_compile(
    name = "protos",
    srcs = ["//examples/helloworld/proto:helloworld.proto"],
    verbose = 1,
    gen_go = True,
)

go_proto_library(
    name = "protolib",
    protos = ["//examples/helloworld/proto:helloworld.proto"],
    srcs = [
        "main.go",
    ],
    verbose = 1,
    gen_go = True,
)
