package(default_visibility = ["//visibility:public"])

load("//bzl:rules.bzl", "protoc_go")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

protoc_go(
    name = "protos",
    srcs = ["//examples/helloworld/proto:srcs"],
    # import_map = {
    #     "examples/helloworld/go/proto/helloworld.proto": "pubref.org/rules_pubref/examples/helloworld_foo",
    # },
    verbose = 0,
    with_grpc = True,
)

# To update this, copy the generated file from the :proto rule into
# the source tree.
#
# $cp bazel-genfiles/examples/helloworld/go/helloworld examples/helloworld/go/helloworld
#

go_library(
    name = "helloworld",
    srcs = [
        "helloworld.pb.go",
    ],
    deps = [
        "@com_github_golang_glog//:go_default_library",
        "@com_github_golang_protobuf//:proto",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//:context",
    ],
)
