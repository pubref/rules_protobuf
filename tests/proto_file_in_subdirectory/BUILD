load("//cpp:rules.bzl", "cc_proto_library")
load("//python:rules.bzl", "py_proto_compile")

cc_test(
    name = "test",
    size = "small",
    srcs = ["qux_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        ":baz_cc_proto",
        "@gtest//:gtest",
    ],
)

cc_proto_library(
    name = "baz_cc_proto",
    protos = [
        "foo/bar/baz.proto",
    ],
    verbose = 0,
)

py_proto_compile(
    name = "baz_py_proto",
    protos = [
        "foo/bar/baz.proto",
        "foo/bar/options.proto",
    ],
    verbose = 0,
)
