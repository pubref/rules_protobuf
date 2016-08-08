workspace(name = "org_pubref_rules_protobuf")

# ================================================================
# Go language requires rules_go
# ================================================================

git_repository(
    name = "io_bazel_rules_go",
    remote = "https://github.com/bazelbuild/rules_go.git",
    tag = "0.0.4",
)

load("@io_bazel_rules_go//go:def.bzl", "go_repositories")
go_repositories()

# ================================================================
# Load self
# ================================================================

load("//bzl:protobuf.bzl", "protobuf_repositories")

protobuf_repositories(
    go = True,
    java = True,
    ruby = True,
    python = True,
    cpp = True,
    with_grpc = True,
)
