package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library")
load("//bzl:go/rules.bzl", "go_proto_library")
load("//bzl:grpc_gateway/rules.bzl", "gateway_proto_library")

filegroup(
    name = "srcs",
    srcs = ["helloworld.proto"],
)

go_proto_library(
    name = "go",
    srcs = [":srcs"],
    verbose = 0,
    with_grpc = True,
    deps = [
        "//examples/proto:go_default_library",
    ],
)

cc_proto_library(
    name = "cpp",
    srcs = [":srcs"],
    verbose = 0,
    with_grpc = True,
    deps = [
        "//examples/proto:cpp",
    ],
)

gateway_proto_library(
    name = "gw",
    srcs = ["helloworld_gateway.proto"],
    verbose = 0,
)

# py_proto_library(
#     name = "pylib",
#     protos = ["helloworld.proto"],
#     with_grpc = False,
# )
