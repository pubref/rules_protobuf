package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "go",
    pb_file_extensions = [".pb.go"],
    pb_plugin = "@com_github_golang_protobuf//:protoc_gen_go",
    pb_plugin_implements_grpc = True,
    prefix = "//:go_prefix",
)
