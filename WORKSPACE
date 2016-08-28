workspace(name = "org_pubref_rules_protobuf")

# ================================================================
# Go support requires rules_go
# ================================================================

git_repository(
    name = "io_bazel_rules_go",
    #tag = "0.0.4",
    commit = "fbd0bc8f5cf2526533c9b9846db0f2f242113faf",
    remote = "https://github.com/bazelbuild/rules_go.git",
)

load("@io_bazel_rules_go//go:def.bzl", "go_repositories")

go_repositories()

# ================================================================
# Load self
# ================================================================

load("//bzl:rules.bzl", "protobuf_repositories")

protobuf_repositories(
    # For demonstration purposes of how to override dependencies.
    overrides = {
        "com_github_golang_protobuf": {
            "commit": "2c1988e8c18d14b142c0b472624f71647cf39adb",  # Aug 8, 2016
        },
    },
    verbose = 0,
    with_cpp = True,
    with_go = True,
    with_grpc_gateway = True,
    with_java = True,
    with_javanano = True,
    with_js = True,
    # with_python = True,
    # with_ruby = True,
)
