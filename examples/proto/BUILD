package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library")
load("//bzl:go/rules.bzl", "go_proto_library")
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
    verbose = 0,
)

cc_proto_library(
    name = "cpp",
    protos = [":protos"],
    verbose = 1,
)

# This must be called with ':rb.pb' due to lack of implementing library rule for the moment.
#
ruby_proto_library(
    name = "rb",
    protos = [":protos"],
    verbose = 1,
)
