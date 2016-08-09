load("//bzl:java/class.bzl", JAVA = "CLASS")

java_test(
    name = "netty_test",
    test_class = "org.pubref.rules_protobuf.examples.helloworld.server.HelloWorldServerTest",
    srcs = [
        "HelloWorldServerTest.java",
    ],
    deps = [
        ":server_alt1",
        "@junit_junit_4//jar",
    ],
    runtime_deps = JAVA.grpc.netty_runtime_deps,
)

java_binary(
    name = "netty",
    main_class = "org.pubref.rules_protobuf.examples.helloworld.server.HelloWorldServer",
    runtime_deps = [
        ":server_alt1",
    ] + JAVA.grpc.netty_runtime_deps,
)

java_library(
    name = "server_alt1",
    srcs = [
        "HelloWorldServer.java",
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/proto:proto.srcjar",
    ],
    deps = JAVA.grpc.compile_deps,
)

java_library(
    name = "server_alt2",
    srcs = [
        "HelloWorldServer.java",
    ],
    deps = [
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/proto:protolib",
    ] + JAVA.grpc.compile_deps,
)
