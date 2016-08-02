package(default_visibility = ["//visibility:public"])

load("//bzl:rules.bzl", "protoc_py")

protoc_py(
    name = "proto",
    srcs = ["//examples/helloworld/proto:srcs"],
    with_grpc = True,
    verbose = 1,
)

py_binary(
    name = "client",
    srcs = [
        "client.py",
        ":proto",
    ],
    deps = [
    ],
)
