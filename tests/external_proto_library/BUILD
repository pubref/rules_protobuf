package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_prefix")
load("@org_pubref_rules_protobuf//cpp:rules.bzl", "cc_proto_library")
load("@org_pubref_rules_protobuf//java:rules.bzl", "java_proto_library")
load("@org_pubref_rules_protobuf//go:rules.bzl", "go_proto_library")

go_prefix("github.com/pubref/rules_protobuf/tests/external_proto_library")

cc_proto_library(
    name = "cc_gapi",
    imports = [
        "external/com_github_googleapis_googleapis",
    ],
    proto_deps = [
        "@com_github_googleapis_googleapis//:label_cc_proto",
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
        "@com_github_googleapis_googleapis//:label_java_proto",
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
        "@com_github_googleapis_googleapis//:label_go_proto",
    ],
    protos = ["message.proto"],
    verbose = 0,
)

# Another (probably easier) way of getting the label.proto compiled.
# Commented out here as both the go_gapi and go_gapi_alternate
# generate the same message.pb.go (conflicting actions).
# go_proto_library(
#     name = "go_gapi_alternate",
#     imports = [
#         "external/com_github_googleapis_googleapis",
#     ],
#     proto_deps = [
#         ":label_go_proto",
#     ],
#     protos = ["message.proto"],
#     verbose = 0,
# )

# This is an example of cherry picking  go protos in external workspaces as well.  In this case it has the
# go_package option.
go_proto_library(
    name = "label_go_proto",
    go_package = "google.golang.org/genproto/googleapis/api/label",
    protos = [
        "@com_github_googleapis_googleapis//:google/api/label.proto",
    ],
)
