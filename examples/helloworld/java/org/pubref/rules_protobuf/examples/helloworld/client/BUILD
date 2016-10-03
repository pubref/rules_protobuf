java_test(
    name = "netty_test",
    size = "small",
    srcs = ["HelloWorldClientTest.java"],
    tags = ["exclusive"],
    test_class = "org.pubref.rules_protobuf.examples.helloworld.client.HelloWorldClientTest",
    runtime_deps = [
        "//java:netty_runtime_deps",
    ],
    deps = [
        ":client",
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/server",
        "@junit_junit_4//jar",
    ],
)

java_binary(
    name = "netty",
    main_class = "org.pubref.rules_protobuf.examples.helloworld.client.HelloWorldClient",
    runtime_deps = [
        ":client",
        "//java:netty_runtime_deps",
    ],
)

java_library(
    name = "client",
    srcs = ["HelloWorldClient.java"],
    deps = [
        "//examples/helloworld/proto:java",
        "//java:grpc_compiletime_deps",
    ],
)
