load("//bzl:java/class.bzl", JAVA = "CLASS")


java_test(
    name = "netty_test",
    test_class = "org.pubref.rules_protobuf.examples.helloworld.client.HelloWorldClientTest",
    srcs = [
        "HelloWorldClientTest.java",
    ],
    deps = [
        ":client",
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/server",
        "@junit_junit_4//jar",
    ],
    runtime_deps = JAVA.grpc.netty_runtime_deps,
)


java_binary(
    name = "netty",
    main_class = "org.pubref.rules_protobuf.examples.helloworld.client.HelloWorldClient",
    runtime_deps = [
        ":client",
    ] + JAVA.grpc.netty_runtime_deps,
)


java_library(
    name = "client",
    srcs = [
        "HelloWorldClient.java",
    ],
    deps = [
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/proto:proto",
    ] + JAVA.grpc.compile_deps,
)


java_library(
    name = "client_from_srcs",
    srcs = [
        "HelloWorldClient.java",
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/proto:srcs",
    ],
    deps = JAVA.grpc.compile_deps,
)
