package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "objc",
    pb_file_extensions = [".pbobjc.h", ".pbobjc.m"],
    output_file_style = "capitalize",
    supports_grpc = False, # not yet implemented to get plugin and deps.
)
