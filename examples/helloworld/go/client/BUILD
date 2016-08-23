package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:go/rules.bzl", "go_proto_compile", "go_proto_library")

go_binary(
    name = "client",
    srcs = ["main.go"],
    deps = [
        "//examples/helloworld/proto:go",
    ] + GO.grpc.compile_deps,
)

# # if you depend on this rule, the proto sources get copied to the
# # namespace of the calling BUILD file (examples/helloworld/go/client),
# # affecting the go "import" naming.
# go_proto_library(
#     name = 'protolib',
#     protos = [
#         '//examples/helloworld/proto:srcs',
#     ],
#     with_grpc = True,
#     verbose = 0,
# )
