package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")
load("//java:rules.bzl", "java_proto_language_import")

proto_language(
    name = "java",
    grpc_compile_deps = [
        "@io_grpc_grpc_netty//jar",
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_context//jar",
        "@com_google_guava_guava//jar",
        "@com_google_errorprone_error_prone_annotations//jar",
        "@com_google_code_findbugs_jsr305//jar",
        "@com_google_instrumentation_instrumentation_api//jar",
        "@io_opencensus_opencensus_api//jar",
        "@io_opencensus_opencensus_contrib_grpc_metrics//jar",
        "@io_netty_netty_codec_http2//jar",
        "@io_netty_netty_codec_http//jar",
        "@io_netty_netty_codec//jar",
        "@io_netty_netty_transport//jar",
        "@io_netty_netty_buffer//jar",
        "@io_netty_netty_common//jar",
        "@io_netty_netty_resolver//jar",
        "@io_netty_netty_handler//jar",
        "@io_netty_netty_handler_proxy//jar",
        "@io_netty_netty_codec_socks//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@com_google_protobuf_protobuf_java//jar",
        "@com_google_protobuf_protobuf_java_util//jar",
        "@com_google_code_gson_gson//jar",
        "@com_google_api_grpc_proto_google_common_protos//jar",
        "@io_grpc_grpc_protobuf_lite//jar",
        "@io_grpc_grpc_stub//jar",
    ],
    grpc_plugin = ":protoc_gen_grpc_java_bin",
    grpc_runtime_deps = [
        "@io_grpc_grpc_netty//jar",
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_context//jar",
        "@com_google_guava_guava//jar",
        "@com_google_errorprone_error_prone_annotations//jar",
        "@com_google_code_findbugs_jsr305//jar",
        "@com_google_instrumentation_instrumentation_api//jar",
        "@io_opencensus_opencensus_api//jar",
        "@io_netty_netty_codec_http2//jar",
        "@io_netty_netty_codec_http//jar",
        "@io_netty_netty_codec//jar",
        "@io_netty_netty_transport//jar",
        "@io_netty_netty_buffer//jar",
        "@io_netty_netty_common//jar",
        "@io_netty_netty_resolver//jar",
        "@io_netty_netty_handler//jar",
        "@io_netty_netty_handler_proxy//jar",
        "@io_netty_netty_codec_socks//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@com_google_protobuf_protobuf_java//jar",
        "@com_google_protobuf_protobuf_java_util//jar",
        "@com_google_code_gson_gson//jar",
        "@com_google_api_grpc_proto_google_common_protos//jar",
        "@io_grpc_grpc_protobuf_lite//jar",
        "@io_grpc_grpc_stub//jar",
    ],
    output_to_jar = True,
    pb_compile_deps = [
        "@com_google_guava_guava//jar",
        "@com_google_protobuf_protobuf_java//jar",
    ],
    pb_file_extensions = [],
    pb_runtime_deps = [],
    supports_grpc = True,
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
    grpc_compile_deps = [
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@io_grpc_grpc_stub//jar",
        "@com_google_protobuf_nano_protobuf_javanano//jar",
        "@io_grpc_grpc_protobuf_nano//jar",
    ],
    grpc_plugin = ":protoc_gen_grpc_java_bin",
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
    output_to_jar = True,
    pb_compile_deps = [
        "@com_google_guava_guava//jar",
        "@com_google_protobuf_protobuf_java//jar",
        "@com_google_protobuf_nano_protobuf_javanano//jar",
    ],
    pb_file_extensions = [],
    pb_options = [
        "ignore_services=true",
    ],
    pb_plugin_name = "javanano",
    pb_runtime_deps = [],
    supports_grpc = True,
)

genrule(
    name = "protoc_gen_grpc_java_bin",
    srcs = select({
        ":darwin": ["@protoc_gen_grpc_java_macosx//file"],
        ":windows": ["@protoc_gen_grpc_java_windows_x86_64//file"],
        ":windows_msvc": ["@protoc_gen_grpc_java_windows_x86_64//file"],
        "//conditions:default": ["@protoc_gen_grpc_java_linux_x86_64//file"],
    }),
    outs = ["protoc_gen_grpc_java"],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$@",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
        "cd $$TMP",
        "cp $$IN $$OUT",
        "rm -rf $$TMP",
    ]),
    executable = True,
)

config_setting(
    name = "darwin",
    values = {"host_cpu": "darwin"},
    visibility = ["//visibility:private"],
)

config_setting(
    name = "windows",
    values = {"host_cpu": "x64_windows"},
    visibility = ["//visibility:private"],
)

config_setting(
    name = "windows_msvc",
    values = {"host_cpu": "x64_windows_msvc"},
    visibility = ["//visibility:private"],
)

java_library(
    name = "grpc_compile",
    visibility = ["//visibility:public"],
    exports = [
        "@com_google_api_grpc_proto_google_common_protos//jar",
        "@com_google_code_findbugs_jsr305//jar",
        "@com_google_code_gson_gson//jar",
        "@com_google_errorprone_error_prone_annotations//jar",
        "@com_google_guava_guava//jar",
        "@com_google_instrumentation_instrumentation_api//jar",
        "@com_google_protobuf_protobuf_java//jar",
        "@com_google_protobuf_protobuf_java_util//jar",
        "@io_grpc_grpc_context//jar",
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_netty//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@io_grpc_grpc_protobuf_lite//jar",
        "@io_grpc_grpc_stub//jar",
        "@io_netty_netty_buffer//jar",
        "@io_netty_netty_codec//jar",
        "@io_netty_netty_codec_http//jar",
        "@io_netty_netty_codec_http2//jar",
        "@io_netty_netty_codec_socks//jar",
        "@io_netty_netty_common//jar",
        "@io_netty_netty_handler//jar",
        "@io_netty_netty_handler_proxy//jar",
        "@io_netty_netty_resolver//jar",
        "@io_netty_netty_transport//jar",
        "@io_opencensus_opencensus_api//jar",
    ],
)

java_library(
    name = "grpc_runtime",
    visibility = ["//visibility:public"],
    exports = [
        "@com_google_api_grpc_proto_google_common_protos//jar",
        "@com_google_code_findbugs_jsr305//jar",
        "@com_google_code_gson_gson//jar",
        "@com_google_errorprone_error_prone_annotations//jar",
        "@com_google_guava_guava//jar",
        "@com_google_instrumentation_instrumentation_api//jar",
        "@com_google_protobuf_protobuf_java//jar",
        "@com_google_protobuf_protobuf_java_util//jar",
        "@io_grpc_grpc_context//jar",
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_netty//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@io_grpc_grpc_protobuf_lite//jar",
        "@io_grpc_grpc_stub//jar",
        "@io_netty_netty_buffer//jar",
        "@io_netty_netty_codec//jar",
        "@io_netty_netty_codec_http//jar",
        "@io_netty_netty_codec_http2//jar",
        "@io_netty_netty_codec_socks//jar",
        "@io_netty_netty_common//jar",
        "@io_netty_netty_handler//jar",
        "@io_netty_netty_handler_proxy//jar",
        "@io_netty_netty_resolver//jar",
        "@io_netty_netty_transport//jar",
        "@io_opencensus_opencensus_api//jar",
    ],
)
