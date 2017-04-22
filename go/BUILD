package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "go",
    pb_file_extensions = [".pb.go"],
    pb_plugin = "@com_github_golang_protobuf//protoc-gen-go",
    pb_plugin_implements_grpc = True,
    go_prefix = "//:go_prefix",
    pb_imports = [
        "external/com_github_google_protobuf/src",
    ],
    pb_inputs = [
        "@com_github_google_protobuf//:well_known_protos",
    ],
)

proto_language(
    name = "go_without_wkt",
    pb_file_extensions = [".pb.go"],
    pb_plugin = "@com_github_golang_protobuf//protoc-gen-go",
    pb_plugin_implements_grpc = True,
    go_prefix = "//:go_prefix",
)
