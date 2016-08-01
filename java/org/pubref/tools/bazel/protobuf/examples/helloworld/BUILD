package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "protobuf_java_library")

protobuf_java_library(
    name = "protobufs",
    src = "helloworld.proto",
    with_grpc_plugin = True,
    verbose = True,
)
