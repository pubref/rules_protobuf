package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library")
load("//bzl:csharp/rules.bzl", "csharp_proto_library")
load("//bzl:go/rules.bzl", "go_proto_library")
load("//bzl:java/rules.bzl", "java_proto_library")
load("//bzl:ruby/rules.bzl", "ruby_proto_library")

filegroup(
    name = "protos",
    srcs = [
        "common.proto",
    ],
)

go_proto_library(
    name = "go_default_library",
    protos = [":protos"],
    verbose = 1,
)

cc_proto_library(
    name = "cpp",
    protos = [":protos"],
    verbose = 1,
)

# Work-in-progress.  This must be called with ':rb.pb' due to lack of
# implementing library rule for the moment.
#
ruby_proto_library(
    name = "rb",
    protos = [":protos"],
    verbose = 1,
)

java_proto_library(
    name = "java",
    protos = [":protos"],
    verbose = 1,
)

# Work-in-progress. This must be called with ':cs.pb' due to lack of
# implementing library rule for the moment.  It also gets placed in
# the outdir directly rather than the package dir.
#
# csharp_proto_library(
#     name = "csharp",
#     protos = [":protos"],
#     verbose = 1,
# )
