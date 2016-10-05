package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_test")

load("//go:rules.bzl", "go_proto_library")

#
# Demonstration of importing the protobuf well-known types.
#

go_proto_library(
    name = "protolib",
    protos = ["wkt.proto"],
    imports = [
        'external/com_github_google_protobuf/src',
    ],
    importmap = {
        'google/protobuf/descriptor.proto': 'github.com/golang/protobuf/protoc-gen-go/descriptor',
        'google/protobuf/compiler/plugin.proto': 'github.com/golang/protobuf/protoc-gen-go/plugin',
    },
    deps = [
        "@com_github_golang_protobuf//:ptypes/any",
        "@com_github_golang_protobuf//:ptypes/duration",
        "@com_github_golang_protobuf//:ptypes/timestamp",
        "@com_github_golang_protobuf//:ptypes/empty",
        "@com_github_golang_protobuf//:ptypes/struct",
        "@com_github_golang_protobuf//:ptypes/wrappers",
        "@com_github_golang_protobuf//:protoc-gen-go/descriptor",
        "@com_github_golang_protobuf//:protoc-gen-go/plugin",
    ],
)

go_test(
    name = "wkt_test",
    size = "small",
    srcs = ["wkt_test.go"],
    deps = [
        "protolib",
        "@com_github_golang_protobuf//:protoc-gen-go/descriptor",
    ],
)
