package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "rust",
    grpc_file_extensions = ["_grpc.rs"],
    grpc_plugin = "@com_github_stepancheg_grpc_rust//:protoc_gen_rust_grpc",
    output_to_libsubdir = True,
    pb_file_extensions = [".rs"],
    pb_plugin = "@com_github_stepancheg_rust_protobuf//:protoc_gen_rust",
    pb_plugin_implements_grpc = False,
    supports_grpc = True,
)
