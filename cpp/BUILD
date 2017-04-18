package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "cpp",
    grpc_compile_deps = [
        "@com_google_grpc//:grpc++",
        "@com_google_grpc//:grpc++_reflection",
    ],
    grpc_file_extensions = [
        ".grpc.pb.h",
        ".grpc.pb.cc",
    ],
    grpc_plugin = "//external:protoc_gen_grpc_cpp",
    grpc_plugin_name = "grpc_cpp",
    pb_compile_deps = [
        "//external:protobuf_clib",
    ],
    pb_file_extensions = [
        ".pb.h",
        ".pb.cc",
    ],
    pb_inputs = [
        "@com_github_google_protobuf//:well_known_protos",
    ],
    pb_imports = [
        "external/com_github_google_protobuf/src",
    ],
    supports_grpc = True,
)
