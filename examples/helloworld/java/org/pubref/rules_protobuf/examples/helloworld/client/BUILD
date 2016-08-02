java_binary(
    name = "netty_client",
    main_class = "org.pubref.rules_protobuf.examples.helloworld.client.HelloWorldClient",
    runtime_deps = [
        ":client",
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
    name = "client",
    srcs = [
        "HelloWorldClient.java",
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/proto",
    ],
    deps = [
        "@com_google_guava_guava//jar",
        "@com_google_protobuf_protobuf_java//jar",
        "@io_grpc_grpc_core//jar",
        "@io_grpc_grpc_protobuf//jar",
        "@io_grpc_grpc_stub//jar",
    ],
)
