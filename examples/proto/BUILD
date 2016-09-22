package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_compile")
load("//cpp:rules.bzl", "cc_proto_library")
load("//csharp:rules.bzl", "csharp_proto_compile", "csharp_proto_library")
load("//go:rules.bzl", "go_proto_library")
load("//java:rules.bzl", "java_proto_library")
load("//closure:rules.bzl", "closure_proto_library")
load("//node:rules.bzl", "node_proto_compile")
load("//objc:rules.bzl", "objc_proto_library")

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
)

cc_proto_library(
    name = "cpp",
    protos = [":protos"],
)

java_proto_library(
    name = "java",
    protos = [":protos"],
    verbose = 0,
)

proto_compile(
    name = "rb",
    langs = ["//ruby"],
    protos = [":protos"],
    verbose = 0,
)

csharp_proto_library(
    name = "csharp",
    protos = [":protos"],
    with_grpc = False,
    verbose = 0,
)

# This conflicts with outputs from other rules here but demonstrates
# how to generate multiple language outputs simultaneously.

# proto_compile(
#     name = "pluri",
#     protos = [":protos"],
#     langs = [
#         "//ruby",
#         "//java",
#         "//java:nano",
#         "//python",
#         "//cpp",
#         "//objc",
#         "//closure",
#         "//node",
#     ],
#     verbose = 2,
#     with_grpc = True,
# )
