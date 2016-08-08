package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library")

# protoc_cpp(
#     name = "protos",
#     srcs = ["//examples/helloworld/proto:srcs"],
#     verbose = 1,
#     with_grpc = True,
# )

cc_proto_library(
    name = 'protos',
    protos = [
        'helloworld.proto',
    ],
    srcs = [
        'greeter_client.cc',
    ],
    deps = [
        '@com_github_grpc_grpc//:grpc++',
    ],

    linkopts = ['-ldl'],
)

cc_binary(
    name = 'client',
    srcs = [
        ':protos_pb',
        'greeter_client.cc',
    ],
    deps = [
        ':protos',
        '@com_github_grpc_grpc//:grpc++',
    ],
    linkopts = ['-ldl'],
)

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
