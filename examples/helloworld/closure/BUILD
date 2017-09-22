package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_library")
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_test")
load("//closure:rules.bzl", "closure_proto_library")

closure_proto_library(
    name = "protolib",
    protos = [
        "//examples/helloworld/proto:protos",
        "//examples/proto:protos",
    ],
    verbose = 0,
)

closure_js_library(
    name = "greeter",
    srcs = [
        "greeter.js",
        #"protolib.pb",
    ],
    deps = [
        ":protolib",
        "@io_bazel_rules_closure//closure/library",
        "@io_bazel_rules_closure//closure/protobuf:jspb",
    ],
)

closure_js_test(
    name = "greeter_test",
    srcs = ["greeter_test.js"],
    compilation_level = "SIMPLE",
    size = "small",
    deps = [
        ":greeter",
        ":protolib",
        "@io_bazel_rules_closure//closure/library:testing",
        "@io_bazel_rules_closure//closure/protobuf:jspb",
    ],
)
