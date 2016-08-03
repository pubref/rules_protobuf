package(default_visibility = ["//visibility:public"])

load("//bzl:rules.bzl", "protoc_java")

protoc_java(
    name = "proto",
    srcs = ["//examples/helloworld/proto:srcs"],
    verbose = 0,
    with_grpc = True,
)
