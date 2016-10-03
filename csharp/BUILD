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
    grpc_file_extensions = ["Grpc.cs"],
    grpc_plugin = "@com_github_grpc_grpc//:grpc_csharp_plugin",
    grpc_plugin_name = "grpc_csharp",
    grpc_compile_deps = [
        "@nuget_grpc//:core",
    ],
)
