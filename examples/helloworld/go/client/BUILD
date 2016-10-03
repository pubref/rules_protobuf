package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load(
    "//go:rules.bzl",
    GO_GRPC_COMPILE_DEPS = "GRPC_COMPILE_DEPS",
)
#load("//gogo:rules.bzl", GOGO_GRPC_COMPILE_DEPS = "GRPC_COMPILE_DEPS")

go_binary(
    name = "client",
    srcs = ["main.go"],
    deps = ["//examples/helloworld/proto:go"] + GO_GRPC_COMPILE_DEPS,
)

# To enable this, uncomment and change the importpath to 'gogo' in
# main.go.
#
# go_binary(
#     name = "gogo_client",
#     srcs = ["main.go"],
#     deps = ["//examples/helloworld/proto:gogo"] + GOGO_GRPC_COMPILE_DEPS,
# )
