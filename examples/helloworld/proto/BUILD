package(default_visibility = ["//visibility:public"])

load("//go:rules.bzl", "go_proto_library")
load("//gogo:rules.bzl", "gogo_proto_library")
load("//protobuf:rules.bzl", "proto_compile")

filegroup(
    name = "protos",
    srcs = ["helloworld.proto"],
)

go_proto_library(
    name = "go",
    proto_deps = [
        "//examples/proto:go_default_library",
    ],
    protos = [":protos"],
    verbose = 0,
    with_grpc = True,
    importpath = "github.com/pubref/rules_protobuf/examples/helloworld/proto/go",
)

# Commented out as this conflicts with go (same output file).
#
# gogo_proto_library(
#     name = "gogo",
#     proto_deps = [
#         "//examples/proto:go_default_library",
#     ],
#     protos = [":protos"],
#     verbose = 1,
#     with_grpc = True,
# )
