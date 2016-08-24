package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library")
load("//bzl:go/rules.bzl", "go_proto_library")

filegroup(
    name = "protos",
    srcs = ["helloworld.proto"],
)

go_proto_library(
    name = "go",
    protos = [":protos"],
    verbose = 0,
    with_grpc = True,
    proto_deps = [
        "//examples/proto:go_default_library",
    ],
)

cc_proto_library(
    name = "cpp",
    protos = [":protos"],
    verbose = 0,
    with_grpc = True,
    proto_deps = [
        "//examples/proto:cpp",
    ],
)

# py_proto_library(
#     name = "pylib",
#     protos = ["helloworld.proto"],
#     with_grpc = False,
# )
