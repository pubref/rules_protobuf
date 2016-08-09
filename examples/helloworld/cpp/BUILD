package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library", "cc_proto_compile")

cc_proto_compile(
    name = 'protos',
    protos = [
        '//examples/helloworld/proto:srcs',
    ],
    gen_grpc_cpp = True,
    verbose = 1,
)

# cc_proto_compile(
#     name = 'protos',
#     protos = [
#         '//examples/helloworld/proto:srcs',
#     ],
#     with_grpc = True,
#     linkopts = ['-ldl'],
# )

cc_binary(
    name = 'client',
    srcs = [
        'greeter_client.cc',
    ],
    deps = [
        ":protos",
    ],
    linkopts = ['-ldl'],
)

cc_binary(
    name = 'server',
    srcs = [
        'greeter_server.cc',
    ],
    deps = [
        ":protos",
    ],
    linkopts = ['-ldl'],
)
