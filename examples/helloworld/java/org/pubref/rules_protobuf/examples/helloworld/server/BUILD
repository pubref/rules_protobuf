package(default_visibility = ["//visibility:public"])

load(
    "//bzl:java/class.bzl",
    JAVA = "CLASS",
)

java_test(
    name = "netty_test",
    size = "small",
    srcs = ["HelloWorldServerTest.java"],
    tags = ["exclusive"],  # Address already in use if another server being tested has same port
    test_class = "org.pubref.rules_protobuf.examples.helloworld.server.HelloWorldServerTest",
    runtime_deps = JAVA.grpc.netty_runtime_deps,
    deps = [
        ":server",
        "@junit_junit_4//jar",
    ],
)

java_binary(
    name = "netty",
    main_class = "org.pubref.rules_protobuf.examples.helloworld.server.HelloWorldServer",
    runtime_deps = [":server"] + JAVA.grpc.netty_runtime_deps,
)

java_library(
    name = "server",
    srcs = ["HelloWorldServer.java"],
    deps = [
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/proto",
    ] + JAVA.grpc.compile_deps,
)

java_library(
    name = "server_alt2",
    srcs = ["HelloWorldServer.java"],
    deps = [
        "//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/proto",
    ] + JAVA.grpc.compile_deps,
)
