load("@io_bazel_rules_go//go:def.bzl", "go_binary")

load("@org_pubref_rules_protobuf//grpc_gateway:rules.bzl", "GRPC_GATEWAY_DEPS")

go_binary(
    name = "server",
    srcs = [
        "server.go",
    ],
    deps = [
        "//proto:greeter_grpc_gateway_go_proto",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//context:go_default_library",
    ],
    visibility = [
        "//visibility:public",
    ],
)

go_binary(
    name = "gateway",
    srcs = [
        "gateway.go",
    ],
    deps = [
        "//proto:greeter_grpc_gateway_go_proto",
        "@com_github_grpc_ecosystem_grpc_gateway//runtime:go_default_library",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//context:go_default_library",
    ],
    visibility = [
        "//visibility:public",
    ],
)

go_binary(
    name = "client",
    srcs = [
        "client.go",
    ],
    visibility = [
        "//visibility:public",
    ],
)

