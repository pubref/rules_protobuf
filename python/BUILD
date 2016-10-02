package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "python",
    pb_file_extensions = ["_pb2.py"],
    supports_grpc = True,
    grpc_file_extensions = ["_pb2.py"],
    grpc_plugin = "@com_github_grpc_grpc//:grpc_python_plugin",
    grpc_plugin_name = "grpc_python",
)
