package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "ruby",
    pb_file_extensions = ["_pb.rb"],
    supports_grpc = True,
    grpc_file_extensions = ["_services_pb.rb"],
    grpc_plugin = "//external:protoc_gen_grpc_ruby",
    grpc_plugin_name = "grpc_ruby",
)
