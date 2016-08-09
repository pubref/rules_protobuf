package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary")

load("//bzl:go/rules.bzl", "go_proto_library")
#load("//bzl:python/rules.bzl", "py_proto_library"
     #)load("//bzl:cpp/rules.bzl", "cc_proto_library")

filegroup(
    name = "srcs",
    srcs = [
        "helloworld.proto",
    ],
)

exports_files(["helloworld.proto"])

# go_proto_library(
#     name = "golib",
#     protos = ["helloworld.proto"],
#     with_grpc = True,
# )

# py_proto_library(
#     name = "pylib",
#     protos = ["helloworld.proto"],
#     with_grpc = False,
# )

# cc_proto_library(
#     name = "cclib",
#     protos = ["helloworld.proto"],
#     with_grpc = True,
# )
