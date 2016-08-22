package(default_visibility = ["//visibility:public"])

load("//bzl:go/rules.bzl", "go_proto_library")
load("//bzl:cpp/rules.bzl", "cc_proto_library")

filegroup(
    name = "srcs",
    srcs = [
        "common.proto",
    ],
)

go_proto_library(
    name = "go_default_library",
    protos = ["common.proto"],
)

cc_proto_library(
    name = "cpplib",
    protos = ["common.proto"],
    verbose = 2,
)
