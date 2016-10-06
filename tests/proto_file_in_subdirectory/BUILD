load("//cpp:rules.bzl", "cc_proto_library")

cc_test(
    name = "test",
    size = "small",
    srcs = ["qux_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        ":protolib",
        "@gtest//:gtest",
    ],
)

cc_proto_library(
    name = "protolib",
    protos = [
        "foo/bar/baz.proto",
    ],
    verbose = 0,
)
