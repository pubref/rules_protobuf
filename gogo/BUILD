package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "gogo",
    pb_file_extensions = [".pb.go"],
    pb_plugin = "@com_github_gogo_protobuf//protoc-gen-gogo",
    pb_plugin_implements_grpc = True,
    prefix = "//:go_prefix",
)
