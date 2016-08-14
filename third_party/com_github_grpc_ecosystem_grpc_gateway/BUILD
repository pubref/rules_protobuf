package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")

go_binary(
    name = 'protoc-gen-grpc-gateway',
    srcs = [
    ],
    deps = [
    ],
)


filegroup(
    name = 'googleapis',
    srcs = glob([
        "third_party/googleapis/google/api/*.proto",
    ]),
)
