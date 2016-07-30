load("//protobuf:defs.bzl", "protobuf_java_library")

java_binary(
    name = "helloworld_bin",
    main_class = "org.pubref.tools.bazel.protobuf.examples.helloworld.HelloWorld",
    runtime_deps = [
        ":helloworld",
    ],
)

java_library(
    name = "helloworld",
    srcs = [
        "HelloWorld.java",
    ],
    deps = [
        ":protos",
    ],
)

protobuf_java_library(
    name = "protos",
    src = "helloworld.proto",
)
