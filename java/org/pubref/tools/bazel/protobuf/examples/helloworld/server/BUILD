java_binary(
    name = "netty_server",
    main_class = "org.pubref.tools.bazel.protobuf.examples.helloworld.server.HelloWorldServer",
    runtime_deps = [
        ":server",
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

java_library(
    name = "server",
    srcs = [
        "HelloWorldServer.java",
        "//java/org/pubref/tools/bazel/protobuf/examples/helloworld:protobufs",
    ],
    deps = [
        "@com_google_guava_guava//jar",
        "@com_google_protobuf_protobuf_java//jar",
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@io_grpc_grpc_stub//jar",
    ],
)
