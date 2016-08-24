package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library")
load("//bzl:go/rules.bzl", "go_proto_library")

filegroup(
    name = "srcs",
    srcs = [
        "common.proto",
    ],
)

go_proto_library(
    name = "go_default_library",
    srcs = [":srcs"],
)

cc_proto_library(
    name = "cpp",
    srcs = [":srcs"],
    verbose = 0,
)
