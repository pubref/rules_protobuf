package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_test")
load("//bzl:go/rules.bzl", "go_proto_library", "go_proto_compile")

go_proto_compile(
    name = "protos",
    protos = ["//examples/helloworld/proto:helloworld.proto"],
    gen_grpc_go = True,
    verbose = 1,
)

# go_proto_library(
#     name = "golib",
#     protos = ["helloworld.proto"],
#     with_grpc = True,
# )

# go_test(
#     name = "client",
#     srcs = [
#         "main.go",
#     ],
#     deps = [
#         "//examples/helloworld/proto:golib",
#         "@com_github_golang_glog//:go_default_library",
#         "@com_github_golang_protobuf//:proto",
#         "@org_golang_google_grpc//:go_default_library",
#         "@org_golang_x_net//:context",
#     ],
# )

go_binary(
    name = "client",
    srcs = [
        "main.go",
    ],
    deps = [
        "//examples/helloworld/proto:golib",
        "@com_github_golang_glog//:go_default_library",
        "@com_github_golang_protobuf//:proto",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//:context",
    ],
)


# proto_compile(
#     name = "protos",
#     srcs = ["//examples/helloworld/proto:helloworld.proto"],
#     verbose = 1,
#     gen_go = True,
# )

# go_proto_library(
#     name = "protolib",
#     protos = ["//examples/helloworld/proto:helloworld.proto"],
#     srcs = [
#         "main.go",
#     ],
#     verbose = 1,
#     gen_go = True,
# )
