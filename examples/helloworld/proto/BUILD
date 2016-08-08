package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load("//bzl:protobuf.bzl", "proto_compile")
load("//bzl:go/rules.bzl", "go_proto_library")

filegroup(
    name = "srcs",
    srcs = [
        "helloworld.proto",
    ],
)

go_proto_library(
    name = "golib",
    protos = ["helloworld.proto"],
    verbose = 1,
    gen_go = True,
)
