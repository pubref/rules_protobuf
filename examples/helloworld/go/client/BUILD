package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load("//bzl:go/class.bzl", GO = "CLASS")

go_binary(
    name = "client",
    srcs = [
        "main.go",
    ],
    deps = [
        "//examples/helloworld/proto:go",
    ] + GO.grpc.compile_deps,
)


# Unlike CPP and JAVA, The GO rules don't work like this, one has to
# depend on the library and not the source files.
#
# go_binary(
#     name = "client_from_source",
#     srcs = [
#         "main.go",
#         "//examples/helloworld/proto:go_pb",
#     ],
#     deps = GO.grpc.compile_deps,
# )
#


# This will generate protobuf classes, but the generated files cannot
# be transitively used in other dependent rules.
#
#load("//bzl:go/rules.bzl", "go_proto_compile")
# go_proto_compile(
#     name = "protos",
#     protos = ["//examples/helloworld/proto:helloworld.proto"],
#     gen_grpc_go = True,
#     verbose = 1,
# )
