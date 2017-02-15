package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "csharp",
    grpc_compile_deps = [
        "@nuget_grpc//:core",
    ],
    grpc_file_extensions = ["Grpc.cs"],
    grpc_plugin = "@com_github_grpc_grpc//:grpc_csharp_plugin",
    grpc_plugin_name = "grpc_csharp",
    output_file_style = "pascal",
    output_to_libdir = True,
    pb_compile_deps = [
        "@nuget_google_protobuf//:libnet45",
    ],
    pb_file_extensions = [".cs"],
    supports_grpc = True,
)
