workspace(name = "org_pubref_rules_protobuf")

load("//protobuf:rules.bzl", "github_archive")

# ================================================================
# Go support requires rules_go
# ================================================================

github_archive(
    name = "io_bazel_rules_go",
    commit = "6d900bc95ae678bec5c91031b8e987957d2a7f93",  # post-0.7.0 (includes important cross-compile fixes)
    org = "bazelbuild",
    repo = "rules_go",
    sha256 = "d36baba631b29151434726eb204fa93ce8793b5f8ef96da452f382d77bd95c93",
)

load("@io_bazel_rules_go//go:def.bzl", "go_rules_dependencies", "go_register_toolchains")

go_rules_dependencies()

go_register_toolchains()

# ================================================================
# closure js_proto_library support requires rules_closure
# ================================================================

github_archive(
    name = "io_bazel_rules_closure",
    commit = "f4d0633f14570313b94822223039ebda0f398102",
    org = "bazelbuild",
    repo = "rules_closure",
    sha256 = "8e615c1c282ba680e667549e242cfcc0643846ee7c0c8c816bee077b3edda567",
)

load("@io_bazel_rules_closure//closure:defs.bzl", "closure_repositories")

closure_repositories(omit_com_google_protobuf=True)

# ================================================================
# csharp_proto_library support requires rules_dotnet (forked)
# ================================================================

github_archive(
    name = "io_bazel_rules_dotnet",
    commit = "1a6ca96fe05bca83782464453ac4657fb8ed8379",
    org = "bazelbuild",
    repo = "rules_dotnet",
    sha256 = "0f7d7f79bf543fdcce9ffebf422df2f858eae63367869b441d4d1005f279fa1f",
)

load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "csharp_repositories")

csharp_repositories()

# ================================================================
# node_proto_library support requires rules_node
# ================================================================


github_archive(
    name = "org_pubref_rules_node",
    # This commit is *not* on master but rather https://github.com/pubref/rules_node/pull/41.
    commit = "f990afc34168f81b034e642aa0dcb56320ed3988",
    org = "pubref",
    repo = "rules_node",
    sha256 = "a367add895f201595b618611dcf7bdd7723ffeed88c4dc327e30668d19c9d1e2",
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
