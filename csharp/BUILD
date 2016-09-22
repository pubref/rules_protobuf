package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "csharp",
    pb_file_extensions = [".cs"],
    output_file_style = "pascal",
    output_to_libdir = True,
    pb_compile_deps = [
        "@nuget_google_protobuf//:libnet45",
    ],
    supports_grpc = True,
    grpc_plugin = "@nuget_grpc_tools//:protoc-gen-grpc-csharp_bin",
    grpc_file_extensions = ["Grpc.cs"],
    grpc_compile_deps = [
        "@nuget_grpc//:core",
    ],
)
