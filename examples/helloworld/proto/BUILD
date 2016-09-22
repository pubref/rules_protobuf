package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_compile")
load("//cpp:rules.bzl", "cc_proto_library")
load("//go:rules.bzl", "go_proto_library")
load("//gogo:rules.bzl", "gogo_proto_library")
load("//java:rules.bzl", "java_proto_library")
load("//csharp:rules.bzl", "csharp_proto_library")

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

cc_proto_library(
    name = "cpp",
    proto_deps = [
        "//examples/proto:cpp",
    ],
    protos = [":protos"],
    verbose = 0,
    with_grpc = True,
)

java_proto_library(
    name = "java",
    output_to_workspace = False,
    proto_deps = [
        "//examples/proto:java",
    ],
    protos = [":protos"],
    with_grpc = True,
    verbose = 0,
)

proto_compile(
    name = "py",
    langs = ["//python"],
    output_to_workspace = False,
    protos = [":protos"],
    with_grpc = False,
)

proto_compile(
    name = "ruby",
    langs = ["//ruby"],
    output_to_workspace = False,
    protos = [":protos"],
    with_grpc = False,
)

csharp_proto_library(
    name = "Helloworld",
    proto_deps = [
        "//examples/proto:csharp",
    ],
    protos = [":protos"],
    verbose = 0,
    with_grpc = True,
)
