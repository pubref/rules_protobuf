package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "python",
    pb_file_extensions = ["_pb2.py"],
    supports_grpc = True,
    grpc_file_extensions = ["_pb2.py"],
    grpc_plugin = "//external:protoc_gen_grpc_python",
    grpc_plugin_name = "grpc_python",
)
