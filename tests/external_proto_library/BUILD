package(default_visibility = ["//visibility:public"])

load("@org_pubref_rules_protobuf//cpp:rules.bzl", "cc_proto_library")
load("@org_pubref_rules_protobuf//java:rules.bzl", "java_proto_library")
load("@org_pubref_rules_protobuf//go:rules.bzl", "go_proto_library")

cc_proto_library(
    name = "cc_gapi",
    imports = [
        "external/com_github_googleapis_googleapis",
    ],
    proto_deps = [
        "@com_github_googleapis_googleapis//:cc_label_proto",
    ],
    protos = ["message.proto"],
    verbose = 0,
)

java_proto_library(
    name = "java_gapi",
    imports = [
        "external/com_github_googleapis_googleapis",
    ],
    proto_deps = [
        "@com_github_googleapis_googleapis//:java_label_proto",
    ],
    protos = ["message.proto"],
    verbose = 0,
)

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
