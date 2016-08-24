package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_test")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:grpc_gateway/class.bzl", GRPC_GATEWAY = "CLASS")
load("//bzl:grpc_gateway/rules.bzl", "grpc_gateway_proto_library", "grpc_gateway_binary")

# grpc_gateway_proto_library(
#     name = "gateway",
#     srcs = ["helloworld.proto"],
#     verbose = 2,
# )

grpc_gateway_binary(
    name = "greeter",
    srcs = ["greeter.go"],
    protolib_name = "gateway",
    protos = ["helloworld.proto"],
    verbose = 0,
)

# go_binary(
#     name = "greeter_gateway",
#     srcs = [
#         "greeter.go",
#     ],
#     deps = [
#         ":gateway",
#         "@com_github_golang_glog//:go_default_library",
#         "@com_github_grpc_ecosystem_grpc_gateway//:runtime",
#         "@org_golang_google_grpc//:go_default_library",
#         "@org_golang_x_net//:context",
#     ],
# )


# grpc_gateway_binary(
#     name = "gateway",
#     srcs = ["helloworld.proto"],
#     go_srcs = ["greeter.go"]
#     verbose = 2,
# )

go_test(
    name = "greeter_test",
    size = "small",
    srcs = [
        "greeter.go",
        "greeter_test.go",
    ],
    deps = [
        ":gateway",
        "//examples/helloworld/go/server:greeter",
        "//examples/helloworld/proto:go",
        "@com_github_golang_protobuf//:jsonpb",
    ] + GRPC_GATEWAY.grpc.compile_deps,
)
