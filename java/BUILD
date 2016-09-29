package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language", "proto_language_deps")
load("//java:rules.bzl", "java_proto_language_import")

proto_language(
    name = "java",
    output_to_jar = True,
    pb_file_extensions = [],
    pb_compile_deps = [
        "@com_google_guava_guava//jar",
        "@com_google_protobuf_protobuf_java//jar",
    ],
    pb_runtime_deps = [],
    supports_grpc = True,
    grpc_plugin = "//third_party/protoc_gen_grpc_java:protoc_gen_grpc_java_bin",
    grpc_compile_deps = [
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@io_grpc_grpc_stub//jar",
        "@io_grpc_grpc_auth//jar",
        "@com_google_auth_google_auth_library_credentials//jar",
    ],
    grpc_runtime_deps = [
        "@io_grpc_grpc_netty//jar",
        "@io_grpc_grpc_context//jar",
        "@io_netty_netty_buffer//jar",
        "@io_netty_netty_codec//jar",
        "@io_netty_netty_codec_http2//jar",
        "@io_netty_netty_common//jar",
        "@io_netty_netty_handler//jar",
        "@io_netty_netty_resolver//jar",
        "@io_netty_netty_transport//jar",
        "@io_grpc_grpc_protobuf_lite//jar",
    ],
)

java_proto_language_import(
    name = "grpc_compiletime_deps",
    langs = [":java"],
)

java_proto_language_import(
    name = "netty_runtime_deps",
    langs = [":java"],
    runtime_deps = True,
)

proto_language(
    name = "nano",
    output_to_jar = True,
    pb_plugin_name = "javanano",
    pb_file_extensions = [],
    supports_grpc = True,
    pb_compile_deps = [
        "@com_google_guava_guava//jar",
        "@com_google_protobuf_protobuf_java//jar",
        "@com_google_protobuf_nano_protobuf_javanano//jar",
    ],
    pb_options = [
        "ignore_services=true"
    ],
    pb_runtime_deps = [],
    grpc_plugin = "//third_party/protoc_gen_grpc_java:protoc_gen_grpc_java_bin",
    grpc_compile_deps = [
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@io_grpc_grpc_stub//jar",
        "@com_google_protobuf_nano_protobuf_javanano//jar",
        "@io_grpc_grpc_protobuf_nano//jar",
    ],
    grpc_runtime_deps = [
        "@io_grpc_grpc_netty//jar",
        "@io_grpc_grpc_protobuf_lite//jar",
        "@io_netty_netty_buffer//jar",
        "@io_netty_netty_codec//jar",
        "@io_netty_netty_codec_http2//jar",
        "@io_netty_netty_common//jar",
        "@io_netty_netty_handler//jar",
        "@io_netty_netty_resolver//jar",
        "@io_netty_netty_transport//jar",
    ],
)
