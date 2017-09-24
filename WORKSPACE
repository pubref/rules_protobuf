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
    commit = "4af89ef1db659eb41f110df189b67d4cf14073e1",
    org = "bazelbuild",
    repo = "rules_closure",
    sha256 = "f73b1b3974e7639183e1646737d446d73a966ff57f853a896e19bcccc40e9b7b",
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
    # This commit is *not* on master but rather https://github.com/pubref/rules_node/pull/35.
    commit = "2b4b38dcb76eba98419c932c98bd22fe6e322c9f",
    org = "pubref",
    repo = "rules_node",
    sha256 = "64e30037b931fb01c5c5f2e38477bdd234ba95b51138153c13bec8d156982978",
)

load("@org_pubref_rules_node//node:rules.bzl", "node_repositories", "yarn_modules")

node_repositories()

yarn_modules(
    name = "yarn_modules",
    package_json = "//node:package.json",
)

# ================================================================
# Python GRPC support requires rules_python
# ================================================================

github_archive(
    name = "io_bazel_rules_python",
    commit = "fa77c9c1118380e066c88b955c90fb3c7353429e",
    org = "bazelbuild",
    repo = "rules_python",
    sha256 = "7d06126d0d10ea8e63cc7eaf774d9ecebcd9583094ee8e93b0035da659eab5c1",
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

java_proto_repositories(
    # Already picking these up from rules_closure
    excludes = [
        "com_google_code_findbugs_jsr305",
        "com_google_errorprone_error_prone_annotations",
    ],
)
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
