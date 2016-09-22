package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # BSD

load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load("//bzl:go/rules.bzl", "go_proto_library")

filegroup(
    name = "protobufs",
    srcs = glob([
        "src/google/protobuf/*.proto",
    ]),
)

go_proto_library(
    name = "gocore",
    protos = [
        "src/google/protobuf/descriptor.proto",
    ],
)

filegroup(
    name = "protobufs",
    srcs = glob([
        "src/google/protobuf/*.proto",
    ]),
)
