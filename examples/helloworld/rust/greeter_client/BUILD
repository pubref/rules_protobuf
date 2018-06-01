load("@io_bazel_rules_rust//rust:rust.bzl", "rust_binary")
load("//rust:rules.bzl", "GRPC_COMPILE_DEPS", "rust_proto_library")

rust_binary(
    name = "greeter_client",
    srcs = ["greeter_client.rs"],
    deps = ["//examples/helloworld/rust:helloworld"] + GRPC_COMPILE_DEPS,
    visibility = ["//examples/helloworld/rust:__subpackages__"],
)
