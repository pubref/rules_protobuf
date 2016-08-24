package(default_visibility = ["//visibility:public"])

load("//bzl:java/rules.bzl", "java_proto_library", "java_proto_compile")

java_proto_library(
    name = "proto",
    srcs = [
        "//examples/helloworld/proto:srcs",
        "//examples/proto:srcs",
    ],
    verbose = 0,
    with_grpc = True,
)
