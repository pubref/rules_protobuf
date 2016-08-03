package(default_visibility = ["//visibility:public"])

load("//bzl:rules.bzl", "protoc_cpp")

protoc_cpp(
    name = "proto",
    srcs = ["//examples/helloworld/proto:srcs"],
    verbose = 1,
    with_grpc = True,
)

cc_binary(
    name = 'greeter_client',
    srcs = ['greeter_client.cc'],
    deps = [
        ':proto',
        #'@grpc//:grpc++',
    ],
    linkopts = ['-ldl'],
)

cc_binary(
    name = 'greeter_server',
    srcs = ['greeter_server.cc'],
    deps = [
        ':proto',
        #'@grpc//:grpc++',
    ],
    linkopts = ['-ldl'],
)
