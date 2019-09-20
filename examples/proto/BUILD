package(default_visibility = ["//visibility:public"])

load("//closure:rules.bzl", "closure_proto_library")
load("//go:rules.bzl", "go_proto_library")

filegroup(
    name = "protos",
    srcs = [
        "common.proto",
    ],
)

go_proto_library(
    name = "go_default_library",
    protos = [":protos"],
    verbose = 0,
    importpath = "github.com/pubref/rules_protobuf/examples/proto",
)

# This conflicts with outputs from other rules here but demonstrates
# how to generate multiple language outputs simultaneously.
#
# proto_compile(
#     name = "pluriproto",
#     protos = [":protos"],
#     langs = [
#         "//closure",
#         "//go",
#     ],
#     verbose = 2,
#     with_grpc = True,
# )
