load("@io_bazel_rules_go//go:def.bzl", "go_binary")

load("@org_pubref_rules_protobuf//gogo:rules.bzl", "gogo_proto_library")

gogo_proto_library(
    name = "api_proto_go",
    protos = [
        "api.proto",
    ],
    importpath = "github.com/pubref/rules_protobuf/tests/gogo/api",
    with_grpc = True,
)

go_binary(
    name = "client",
    srcs = [
        "client.go",
    ],
    deps = [
        ":api_proto_go",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//context:go_default_library",
    ],
    importpath = "github.com/pubref/rules_protobuf/tests/gogo/client",
)

go_binary(
    name = "server",
    srcs = [
        "server.go",
    ],
    deps = [
        ":api_proto_go",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//context:go_default_library",
    ],
    importpath = "github.com/pubref/rules_protobuf/tests/gogo/server",
)

sh_test(
    name = "gogo_test",
    srcs = [
        "gogo_test.sh",
    ],
    data = [
        ":client",
        ":server",
    ],
    size = "small",
)
