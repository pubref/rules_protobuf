workspace(name = "org_pubref_rules_protobuf")

# ================================================================
# Go support requires rules_go
# ================================================================

git_repository(
    name = "io_bazel_rules_go",
    commit = "4c73b9cb84c1f8e32e7df3c26e237439699d5d8c",
    remote = "https://github.com/bazelbuild/rules_go.git",
)

load("@io_bazel_rules_go//go:def.bzl", "go_repositories")

go_repositories()

# ================================================================
# closure js_proto_library support requires rules_closure
# ================================================================

http_archive(
    name = "io_bazel_rules_closure",
    sha256 = "59498e75805ad8767625729b433b9409f80d0ab985068d513f880fc1928eb39f",
    strip_prefix = "rules_closure-0.3.0",
    url = "http://bazel-mirror.storage.googleapis.com/github.com/bazelbuild/rules_closure/archive/0.3.0.tar.gz",
)

load("@io_bazel_rules_closure//closure:defs.bzl", "closure_repositories")

closure_repositories()

# ================================================================
# csharp_proto_library support requires rules_dotnet (fork)
# ================================================================

git_repository(
    name = "io_bazel_rules_dotnet",
    remote = "https://github.com/pcj/rules_dotnet.git",
    commit = "b23e796dd0be27f35867590309d79ffe278d4eeb",
)

load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "csharp_repositories")

csharp_repositories(use_local_mono = False)

# ================================================================
# Specific Languages Support
# ================================================================

load("//protobuf:rules.bzl", "proto_repositories")
proto_repositories()

load("//cpp:rules.bzl", "cpp_proto_repositories")
cpp_proto_repositories()

load("//java:rules.bzl", "java_proto_repositories", "nano_proto_repositories")
java_proto_repositories()
nano_proto_repositories()

load("//go:rules.bzl", "go_proto_repositories")
go_proto_repositories()

load("//gogo:rules.bzl", "gogo_proto_repositories")
gogo_proto_repositories()

load("//csharp:rules.bzl", "csharp_proto_repositories")
csharp_proto_repositories()

load("//objc:rules.bzl", "objc_proto_repositories")
objc_proto_repositories()

load("//grpc_gateway:rules.bzl", "grpc_gateway_proto_repositories")
grpc_gateway_proto_repositories()
