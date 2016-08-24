package(default_visibility = ["//visibility:public"])

load("//bzl:java/rules.bzl", "java_proto_library")

java_proto_library(
    name = "proto",
    protos = [
        "//examples/helloworld/proto:protos",
        "//examples/proto:protos",
    ],
    verbose = 0,
    with_grpc = True,
)
