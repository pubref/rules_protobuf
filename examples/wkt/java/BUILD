package(default_visibility = ["//visibility:public"])

load("//java:rules.bzl", "java_proto_library")

java_proto_library(
    name = "google_well_known_protos",
    protos = ["@com_github_google_protobuf//:well_known_protos"],
)

java_test(
    name = "wkt_test",
    size = "small",
    srcs = ["WktTest.java"],
    test_class = "examples.wkt.java.WktTest",
    deps = [
        ":google_well_known_protos",
        "@junit_junit_4//jar",
    ],
)
