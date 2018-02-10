load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library", "go_test")

go_test(
    name = "import_test",
    srcs = [
        "import_test.go",
    ],
    size = "small",
    deps = [
        "//:root_proto_go",
        "//proto:subdir_proto_go",
    ],
)
