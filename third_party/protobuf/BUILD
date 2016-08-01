package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # BSD

genrule(
    name = "protoc_bin",
    srcs = select({
        ":darwin": ["@protoc_macosx//file"],
        "//conditions:default": ["@protoc_linux_x86_64//file"],
    }),
    outs = ["protoc"],
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

genrule(
    name = "protoc_gen_grpc_java_bin",
    srcs = select({
        ":darwin": ["@protoc_gen_grpc_java_macosx//file"],
        "//conditions:default": ["@protoc_gen_grpc_java_linux_x86_64//file"],
    }),
    outs = ["protoc-gen-grpc-java"],
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
    values = {"cpu": "darwin"},
    visibility = ["//visibility:private"],
)

java_library(
    name = "grpc-compile",
    visibility = ["//visibility:public"],
    exports = [
        "@com_google_guava_guava//jar",
        "@com_google_protobuf_protobuf_java//jar",
        "@io_grpc_grpc_protobuf_lite//jar",
        "@io_grpc_grpc_stub//jar",
    ],
)

java_library(
    name = "grpc-netty-runtime",
    visibility = ["//visibility:public"],
    exports = [
        "@com_google_protobuf_protobuf_java//jar",
        "@com_google_protobuf_protobuf_java_util//jar",
        "@com_squareup_okhttp_okhttp//jar",
        "@com_squareup_okio_okio//jar",
        "@io_grpc_grpc_auth//jar",
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_netty//jar",
        "@io_grpc_grpc_okhttp//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@io_grpc_grpc_protobuf_lite//jar",
        "@io_grpc_grpc_protobuf_nano//jar",
        "@io_grpc_grpc_stub//jar",
        "@io_netty_netty_buffer//jar",
        "@io_netty_netty_codec//jar",
        "@io_netty_netty_codec_http//jar",
        "@io_netty_netty_codec_http2//jar",
        "@io_netty_netty_common//jar",
        "@io_netty_netty_handler//jar",
        "@io_netty_netty_resolver//jar",
        "@io_netty_netty_transport//jar",
    ],
)
