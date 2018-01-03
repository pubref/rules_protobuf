load("@io_bazel_rules_go//go:def.bzl", "go_prefix")

# When the importpath option is used with the go_rules (recommended),
# this declaration becomes moot.
go_prefix("github.com/pubref/rules_protobuf/test/grpc_gateway")


sh_test(
    name = "integration",
    srcs = [
        "integration_test.sh",
    ],
    data = [
        "//go:server",
        "//go:gateway",
        "//go:client",
    ],
    size = "small",
)

