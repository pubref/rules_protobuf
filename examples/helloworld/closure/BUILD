package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_library")
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_test")
load("//closure:rules.bzl", "closure_proto_library")

closure_proto_library(
    name = "protolib",
    protos = [
        "//examples/proto:protos",
        "//examples/helloworld/proto:protos",
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
        "protolib",
        "@io_bazel_rules_closure//closure/protobuf:jspb",
        "@io_bazel_rules_closure//closure/library",
    ],
)

closure_js_test(
    name = "greeter_test",
    srcs = ["greeter_test.js"],
    pedantic = True,
    compilation_level = "SIMPLE",
    deps = [
        "greeter",
        "protolib",
        "@io_bazel_rules_closure//closure/protobuf:jspb",
        "@io_bazel_rules_closure//closure/library:testing",
    ],
)
