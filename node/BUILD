package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "node",
    grpc_file_extensions = ["_grpc_pb.js"],
    grpc_plugin = "@com_github_grpc_grpc//:grpc_node_plugin",
    grpc_plugin_name = "grpc_node",
    pb_file_extensions = ["_pb.js"],
    pb_options = [
        "import_style=commonjs",
        "binary",
    ],
    pb_plugin_name = "js",
    supports_grpc = True,
)
