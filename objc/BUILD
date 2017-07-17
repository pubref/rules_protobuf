package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "objc",
    grpc_file_extensions = [
        ".pbrpc.h",
        ".pbrpc.m",
    ],
    grpc_plugin = "//external:protoc_gen_grpc_objc",
    grpc_plugin_name = "grpc_objc",
    output_file_style = "pascal",
    pb_file_extensions = [
        ".pbobjc.h",
        ".pbobjc.m",
    ],
    supports_grpc = True,
)
