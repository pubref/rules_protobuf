package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "rust",
    grpc_file_extensions = ["_grpc.rs"],
    grpc_plugin = "@org_pubref_rules_protobuf//rust/raze:protoc_gen_rust_grpc",
    output_to_libsubdir = True,
    pb_file_extensions = [".rs"],
    pb_plugin = "@org_pubref_rules_protobuf//rust/raze:protoc_gen_rust",
    pb_plugin_implements_grpc = False,
    supports_grpc = True,
)
