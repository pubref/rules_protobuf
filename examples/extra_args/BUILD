package(default_visibility = ["//visibility:public"])

# https://github.com/pubref/rules_protobuf/issues/57

load("//protobuf:rules.bzl", "proto_compile")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

filegroup(
    name = "protos",
    srcs = ["person.proto"],
)

proto_compile(
    name = "person_proto",
    args = [
        "--include_imports",
        "--include_source_info",
    ],

    # For well-known protos, if needed
    inputs = ["@com_github_google_protobuf//:well_known_protos"],
    protos = ["person.proto"],
    verbose = 0,
)

# pkg_tar rule is used in this example to provide a sink for the
# descriptor file, forcing bazel to actually execute upstream
# dependent rules.
pkg_tar(
    name = "person_tar",
    files = [
        ":person_proto.descriptor_set",
    ],
)
