package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "closure",
    output_to_library = True,
    pb_file_extensions = [".js"],
    pb_options = [
        "import_style=closure",
        "error_on_name_conflict",
        "binary",
    ],
    pb_plugin_name = "js",
)

proto_language(
    name = "browser",
    pb_file_extensions = ["_pb.js"],
    pb_options = [
        "import_style=browser",
        "error_on_name_conflict",
        "binary",
    ],
    pb_plugin_name = "js",
)
