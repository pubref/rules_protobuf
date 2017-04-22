package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_prefix", "go_binary")
load("@org_pubref_rules_protobuf//go:rules.bzl", "go_proto_library", "PB_COMPILE_DEPS")

go_prefix("github.com/pubref/rules_protobuf/tests/go_package")

go_proto_library(
    name = "file_in_package_root",
    go_package = "pubref.org/test/app",
    protos = ["file_in_package_root.proto"],
    verbose = 0,
)

go_binary(
    name = "main",
    srcs = ["main.go"],
    deps = [
        "//proto:config_go_proto",
        ":file_in_package_root",
    ] + PB_COMPILE_DEPS,
)
