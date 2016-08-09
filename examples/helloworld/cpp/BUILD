package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library")

# protoc_cpp(
#     name = "protos",
#     srcs = ["//examples/helloworld/proto:srcs"],
#     verbose = 1,
#     with_grpc = True,
# )

# Goddamn this is a macro, so it always gets invoked no matter what.

# cc_binary(
#     name = 'client_bin',
#     deps = [
#         "@com_github_grpc_grpc//:grpc++",
#         ":client"
#     ],
# )

cc_proto_library(
    name = 'client',
    protos = [
        'helloworld.proto',
    ],
    srcs = [
        'greeter_client.cc',
    ],
    with_grpc = True,
    linkopts = ['-ldl'],
)

# Presence of *.pb.* files in this directory affects the evalution of any
# rule, it seems.

# Native proto_library does nothing: https://github.com/bazelbuild/bazel/blob/75f367c6b5f26244777e26134c61f0c26af2549c/src/main/java/com/google/devtools/build/lib/rules/proto/BazelProtoLibraryRule.java#L54-L56
#
# proto_library(
#     name = 'protos',
#     srcs = [
#         'helloworld.proto',
#     ],
#     proto_compiler = "//external:protoc",
# )

# cc_binary(
#     name = 'client',
#     srcs = [
#         'greeter_client.cc',
#     ],
#     deps = [
#         #'//examples/helloworld/proto:cclib',
#         '@com_github_grpc_grpc//:grpc++',
#     ],
#     linkopts = ['-ldl'],
# )

cc_binary(
    name = 'server',
    srcs = [
        'greeter_server.cc',
        ':protos',
    ],
    deps = [
        '//examples/helloworld/proto:cclib',
        '@com_github_grpc_grpc//:grpc++',
    ],
    linkopts = ['-ldl'],
)
