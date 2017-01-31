package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_test")
load(
    "//grpc_gateway:rules.bzl",
    "grpc_gateway_proto_compile",
    "grpc_gateway_proto_library",
    "grpc_gateway_swagger_compile",
    "grpc_gateway_binary",
    "GRPC_GATEWAY_DEPS",
)

# grpc_gateway_proto_library(
#     name = "gw",
#     protos = ["helloworld.proto"],
# )

grpc_gateway_swagger_compile(
    name = "swagger",
    protos = ["helloworld.proto"],
)

grpc_gateway_binary(
    name = "greeter",
    srcs = ["greeter.go"],
    proto_label = "gateway",
    protos = ["helloworld.proto"],
)

go_test(
    name = "greeter_test",
    size = "small",
    srcs = [
        "greeter.go",
        "greeter_test.go",
    ],
    tags = ["exclusive"],
    deps = [
        ":gateway",
        "//examples/helloworld/go/server:greeter",
        "//examples/helloworld/proto:go",
        "@com_github_golang_protobuf//jsonpb:go_default_library",
    ] + GRPC_GATEWAY_DEPS,
)
