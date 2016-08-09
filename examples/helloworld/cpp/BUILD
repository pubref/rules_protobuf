package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library")

cc_proto_library(
    name = 'proto',
    protos = [
        'helloworld.proto',
    ],
    with_grpc = True,
    linkopts = ['-ldl'],
)

cc_binary(
    name = 'client',
    srcs = [
        'greeter_client.cc',
    ],
    deps = [
        ":proto",
    ],
    linkopts = ['-ldl'],
)

cc_binary(
    name = 'server',
    srcs = [
        'greeter_server.cc',
    ],
    deps = [
        ":proto",
    ],
    linkopts = ['-ldl'],
)
