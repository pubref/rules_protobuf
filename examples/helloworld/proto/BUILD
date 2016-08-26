package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library")
load("//bzl:go/rules.bzl", "go_proto_library")
load("//bzl:python/rules.bzl", "py_proto_library")
load("//bzl:java/rules.bzl", "java_proto_library")

filegroup(
    name = "protos",
    srcs = ["helloworld.proto"],
)

# This duplication of rules is probably why an aspect-based implementation makes sense.

go_proto_library(
    name = "go",
    proto_deps = [
        "//examples/proto:go_default_library",
    ],
    protos = [":protos"],
    verbose = 1,
    with_grpc = True,
)

cc_proto_library(
    name = "cpp",
    proto_deps = [
        "//examples/proto:cpp",
    ],
    protos = [":protos"],
    verbose = 1,
    with_grpc = True,
)

py_proto_library(
    name = "py",
    output_to_workspace = False,
    protos = [":protos"],
    with_grpc = False,
)

java_proto_library(
    name = "java",
    output_to_workspace = False,
    proto_deps = [
        "//examples/proto:java",
    ],
    protos = [":protos"],
    with_grpc = True,
)
