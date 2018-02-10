load("@io_bazel_rules_go//go:def.bzl", "go_prefix")

go_prefix("github.com/pubref/rules_protobuf/tests/go_package")

load("@org_pubref_rules_protobuf//go:rules.bzl", "go_proto_library")

go_proto_library(
    name = "root_proto_go",
    protos = [
        "root.proto",
    ],
    importpath = "github.com/pubref/rules_protobuf/tests/go_package/root",
    go_package = "github.com/pubref/rules_protobuf/tests/go_package/root",
    visibility = ["//visibility:public"],
)
