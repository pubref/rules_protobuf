package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "node",
    pb_plugin_name = "js",
    pb_file_extensions = ["_pb.js"],
    pb_options = [
        "import_style=commonjs",
        "error_on_name_conflict",
        "binary",
    ],
)
