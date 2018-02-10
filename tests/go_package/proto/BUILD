
load("@org_pubref_rules_protobuf//go:rules.bzl", "go_proto_library")

go_proto_library(
    name = "subdir_proto_go",
    protos = [
        "subdir.proto",
    ],
    importpath = "github.com/pubref/rules_protobuf/tests/go_package/subdir",
    go_package = "github.com/pubref/rules_protobuf/tests/go_package/subdir",
    visibility = ["//visibility:public"],
)
