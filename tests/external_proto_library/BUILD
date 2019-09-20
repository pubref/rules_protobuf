package(default_visibility = ["//visibility:public"])

load("@org_pubref_rules_protobuf//go:rules.bzl", "go_proto_library")

go_proto_library(
    name = "go_gapi",
    imports = [
        "external/com_github_googleapis_googleapis",
    ],
    proto_deps = [
        "@com_github_googleapis_googleapis//:go_label_proto",
    ],
    protos = ["message.proto"],
    importpath = "github.com/pubref/rules_protobuf/tests/external_proto_library",
    verbose = 0,
)
