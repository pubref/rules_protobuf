package(default_visibility = ["//visibility:public"])

load("//go:rules.bzl", "go_proto_library")

go_proto_library(
    name = "x",
    protos = [
        "x.proto",
    ],
    verbose = 0,
)

go_proto_library(
    name = "y",
    proto_deps = [
        ":x",
    ],
    protos = [
        "y.proto",
    ],
    verbose = 0,
)
