package(default_visibility = ["//visibility:public"])

load("//closure:rules.bzl", "closure_proto_library")
load("//cpp:rules.bzl", "cc_proto_library")
load("//csharp:rules.bzl", "csharp_proto_compile", "csharp_proto_library")
load("//go:rules.bzl", "go_proto_library")
load("//java:rules.bzl", "java_proto_library")
load("//node:rules.bzl", "node_proto_compile", "node_proto_library")
load("//objc:rules.bzl", "objc_proto_compile")
load("//python:rules.bzl", "py_proto_library")
load("//protobuf:rules.bzl", "proto_compile")
load("//ruby:rules.bzl", "ruby_proto_compile")

filegroup(
    name = "protos",
    srcs = [
        "common.proto",
    ],
)

cc_proto_library(
    name = "cpp",
    protos = [":protos"],
)

csharp_proto_library(
    name = "csharp",
    protos = [":protos"],
    verbose = 0,
    with_grpc = False,
)

go_proto_library(
    name = "go_default_library",
    protos = [":protos"],
    verbose = 0,
    importpath = "github.com/pubref/rules_protobuf/examples/proto",
)

java_proto_library(
    name = "java",
    protos = [":protos"],
)

node_proto_library(
    name = "node",
    protos = [":protos"],
    verbose = 0,
    with_grpc = False,
)

py_proto_library(
    name = "py",
    protos = [":protos"],
    verbose = 0,
    with_grpc = False,
)

objc_proto_compile(
    name = "objc",
    protos = [":protos"],
    verbose = 0,
    with_grpc = False,
)

ruby_proto_compile(
    name = "ruby",
    protos = [":protos"],
    verbose = 0,
    with_grpc = False,
)

# This conflicts with outputs from other rules here but demonstrates
# how to generate multiple language outputs simultaneously.
#
# proto_compile(
#     name = "pluriproto",
#     protos = [":protos"],
#     langs = [
#         "//ruby",
#         "//java",
#         "//java:nano",
#         "//python",
#         "//cpp",
#         "//objc",
#         "//closure",
#         "//csharp",
#         "//go",
#         "//node",
#     ],
#     verbose = 2,
#     with_grpc = True,
# )
