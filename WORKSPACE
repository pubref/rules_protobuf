workspace(name = "org_pubref_rules_protobuf")

# ================================================================
# Go support requires rules_go
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

load("//bzl:rules.bzl", "protobuf_repositories")

protobuf_repositories(
    with_go = True,
    with_java = True,
    with_ruby = True,
    with_python = True,
    with_cpp = True,
    with_grpc = True,
)
