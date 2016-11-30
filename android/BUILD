package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")
load("//java:rules.bzl", "java_proto_language_import")

proto_language(
    name = "android",
    pb_plugin_name = "java",
    output_to_jar = True,
    pb_file_extensions = [],
    pb_compile_deps = [
        "@com_google_guava_guava//jar",
        "@com_google_protobuf_protobuf_java//jar",
    ],

    # The only difference between generating "regular" java sources and "lite" java sources
    # is the 'lite' option to vanilla protoc: i.e. `--java_out=lite:$OUTDIR` vs `--java_out=$OUTDIR`.
    #pb_options = ["lite"],
    pb_runtime_deps = [],

    supports_grpc = True,
    grpc_plugin = "//java:protoc_gen_grpc_java_bin",
    grpc_compile_deps = [
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@io_grpc_grpc_protobuf_lite//jar",
        "@com_google_code_findbugs_jsr305//jar",
        "@javax_annotation_jsr250_api//jar",
        "@io_grpc_grpc_stub//jar",
        "@io_grpc_grpc_auth//jar",
        "@com_google_auth_google_auth_library_credentials//jar",
    ],
    grpc_options = ["lite"],
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
    ],
)

java_proto_language_import(
    name = "grpc_compiletime_deps",
    langs = [":android"],
)

java_proto_language_import(
    name = "netty_runtime_deps",
    langs = [":android"],
    runtime_deps = True,
)
