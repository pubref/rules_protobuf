package(default_visibility = ["//visibility:public"])

load("//bzl:java/class.bzl", JAVA = "CLASS")

java_test(
    name = "netty_test",
    test_class = "org.pubref.rules_protobuf.examples.helloworld.server.HelloWorldServerTest",
    srcs = [
        "HelloWorldServerTest.java",
    ],
    deps = [
        ":server",
        "@junit_junit_4//jar",
    ],
    tags = ["exclusive"], # Address already in use if another server being tested has same port
    runtime_deps = JAVA.grpc.netty_runtime_deps,
)

java_binary(
    name = "netty",
    main_class = "org.pubref.rules_protobuf.examples.helloworld.server.HelloWorldServer",
    runtime_deps = [
        ":server",
    ] + JAVA.grpc.netty_runtime_deps,
)

java_library(
    name = "server",
    srcs = [
        "HelloWorldServer.java",
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/proto:srcs",
    ],
    deps = JAVA.grpc.compile_deps,
)

java_library(
    name = "server_alt2",
    srcs = [
        "HelloWorldServer.java",
    ],
    deps = [
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/proto:proto",
    ] + JAVA.grpc.compile_deps,
)
