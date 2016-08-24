package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load("//bzl:go/rules.bzl", "go_proto_library")
load("//bzl:grpc_gateway/rules.bzl", "grpc_gateway_proto_library")
load("//bzl:cpp/rules.bzl", "cc_proto_library")

filegroup(
    name = "srcs",
    srcs = [
        "helloworld.proto",
    ],
)

go_proto_library(
    name = "go",
    srcs = ["helloworld.proto"],
    verbose = 1,
    with_grpc = True,
    deps = [
        "//examples/proto:go_default_library",
    ],
)

cc_proto_library(
    name = "cpp",
    srcs = ["helloworld.proto"],
    verbose = 0,
    with_grpc = True,
    deps = [
        "//examples/proto:cpp",
    ],
)

# grpc_gateway_proto_library(
#     name = "gw",
#     protos = ["helloworld_gateway.proto"],
#     verbose = 0,
# )

# py_proto_library(
#     name = "pylib",
#     protos = ["helloworld.proto"],
#     with_grpc = False,
# )
