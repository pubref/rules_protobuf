package(default_visibility = ["//visibility:public"])

load("//bzl:rules.bzl", "protoc_cpp")

protoc_cpp(
    name = "proto",
    srcs = ["//examples/helloworld/proto:srcs"],
    verbose = 0,
    with_grpc = True,
)

cc_binary(
    name = 'client',
    srcs = [
        'greeter_client.cc',
        ':proto',
    ],
    deps = [
        '@com_github_grpc_grpc//:grpc++',
    ],
    linkopts = ['-ldl'],
)

cc_binary(
    name = 'server',
    srcs = [
        'greeter_server.cc',
        ':proto',
    ],
    deps = [
        '@com_github_grpc_grpc//:grpc++',
    ],
    linkopts = ['-ldl'],
)
