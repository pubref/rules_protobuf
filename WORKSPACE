workspace(name = "org_pubref_rules_protobuf")

load("//protobuf:rules.bzl", "github_archive")

# ================================================================
# Go support requires rules_go
# ================================================================

github_archive(
    name = "io_bazel_rules_go",
    commit = "ae70411645c171b2056d38a6a959e491949f9afe",  # v0.5.4
    org = "bazelbuild",
    repo = "rules_go",
    sha256 = "ae91c1dfe9b943500f7486f2bb94b9887f881c7709474f3e170c95d414f79698",
)

load("@io_bazel_rules_go//go:def.bzl", "go_repositories")

go_repositories()

# ================================================================
# closure js_proto_library support requires rules_closure
# ================================================================

github_archive(
    name = "io_bazel_rules_closure",
    commit = "a6b65d5c5c9db8968fb8e03115d5e4f6976de8f7",
    org = "bazelbuild",
    repo = "rules_closure",
    sha256 = "1bccdc7ed05fb74ef18aba39e51c059777cd843dc5d0758303deb9745a93c45e",
)

load("@io_bazel_rules_closure//closure:defs.bzl", "closure_repositories")

closure_repositories()

# ================================================================
# csharp_proto_library support requires rules_dotnet (forked)
# ================================================================

github_archive(
    name = "io_bazel_rules_dotnet",
    commit = "ebc7c1cb61d45bd57042c60b6bfabdfff4979466",
    org = "bazelbuild",
    repo = "rules_dotnet",
    sha256 = "b50c4a1133dfa834fab5ff7596e67866f67e252f76649543adca5f0c3fdec140",
)

load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "csharp_repositories")

csharp_repositories()

# ================================================================
# node_proto_library support requires rules_node
# ================================================================

github_archive(
    name = "org_pubref_rules_node",
    commit = "f6fff71fe8b1bee8d3a22e50eca0f76427ab939e",
    org = "pubref",
    repo = "rules_node",
    sha256 = "94c22db354edc9c21541c713f8d8ace381c8fb7b2c232a2b623c393abe9cb8e6",
)

load("@org_pubref_rules_node//node:rules.bzl", "node_repositories")

node_repositories()


# ================================================================
# Python GRPC support requires rules_python
# ================================================================

github_archive(
    name = "io_bazel_rules_python",
    commit = "07fba0f91bb5898d19daeaabf635d08059f7eacd",
    org = "bazelbuild",
    repo = "rules_python",
    sha256 = "53fecb9ddc5d3780006511c9904ed09c15a8aed0644914960db89f56b1e875bd",
)

load("@io_bazel_rules_python//python:pip.bzl", "pip_repositories", "pip_import")

pip_repositories()

pip_import(
   name = "pip_grpcio",
   requirements = "//python:requirements.txt",
)

load("@pip_grpcio//:requirements.bzl", pip_grpcio_install = "pip_install")

pip_grpcio_install()

# ================================================================
# Specific Languages Support
# ================================================================

load("//protobuf:rules.bzl", "proto_repositories")

proto_repositories()

load("//cpp:rules.bzl", "cpp_proto_repositories")

cpp_proto_repositories()

load("//csharp:rules.bzl", "csharp_proto_repositories")

csharp_proto_repositories()

load("//java:rules.bzl", "java_proto_repositories", "nano_proto_repositories")

java_proto_repositories()
#nano_proto_repositories()

load("//go:rules.bzl", "go_proto_repositories")

go_proto_repositories()

load("//gogo:rules.bzl", "gogo_proto_repositories")

gogo_proto_repositories()

load("//grpc_gateway:rules.bzl", "grpc_gateway_proto_repositories")

grpc_gateway_proto_repositories()

load("//node:rules.bzl", "node_proto_repositories")

node_proto_repositories()

load("//objc:rules.bzl", "objc_proto_repositories")

objc_proto_repositories()

load("//python:rules.bzl", "py_proto_repositories")

py_proto_repositories()

load("//ruby:rules.bzl", "ruby_proto_repositories")

ruby_proto_repositories()
