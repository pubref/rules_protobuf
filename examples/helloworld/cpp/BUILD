package(default_visibility = ["//visibility:public"])

load("//bzl:rules.bzl", "protoc_cpp")

protoc_cpp(
    name = "protos",
    srcs = ["//examples/helloworld/proto:srcs"],
    verbose = 1,
    with_grpc = True,
)

cc_binary(
    name = 'client',
    srcs = [
        'greeter_client.cc',
        ':protos',
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
        ':protos',
    ],
    deps = [
        '@com_github_grpc_grpc//:grpc++',
    ],
    linkopts = ['-ldl'],
)
