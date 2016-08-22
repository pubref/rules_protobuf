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

# Go proto library implementation cannot accept proto filesets from
# say, a filegroup.  It needs to be an explicit filename.  This is the
# reason this rule is in the proto dir.
go_proto_library(
    name = "go",
    #name = "go_default_library", a viable alternative
    protos = ["helloworld.proto"],
    verbose = 0,
    with_grpc = True,
)

# cc_proto_library implementation cannot accept proto filesets from
# say, a filegroup.  It needs to be an explicit filename.  This is the
# reason this rule is in the proto dir.
cc_proto_library(
    name = "cpp",
    protos = ["helloworld.proto"],
    verbose = 0,
    with_grpc = True,
)

grpc_gateway_proto_library(
    name = "gw",
    protos = ["helloworld_gateway.proto"],
    verbose = 1,
)

# py_proto_library(
#     name = "pylib",
#     protos = ["helloworld.proto"],
#     with_grpc = False,
# )
