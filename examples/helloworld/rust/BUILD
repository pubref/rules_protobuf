load("//rust:rules.bzl", "rust_proto_library")

rust_proto_library(
    name = "helloworld",
    proto_deps = [
        "//examples/proto:rust",
    ],
    protos = ["//examples/helloworld/proto:protos"],
    verbose = 0,
    visibility = ["//examples/helloworld/rust:__subpackages__"],
    with_grpc = True,
)
