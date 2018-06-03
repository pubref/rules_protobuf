package(default_visibility = ["//visibility:public"])

load("@pip_grpcio//:requirements.bzl", "requirement")
load("@io_bazel_rules_python//python:python.bzl", "py_binary", "py_library")

py_binary(
    name = "greeter_client",
    srcs = [
        "greeter_client.py",
    ],
    deps = [
        "//examples/helloworld/proto:py",
        requirement("grpcio"),
        requirement("protobuf"),
    ],
)

py_binary(
    name = "greeter_server",
    srcs = [":grpc_server"],
)

py_test(
    name = "test_greeter_server",
    srcs = ["test_greeter_server.py"],
    deps = [":grpc_server"],
    size = "small",
)

# This library is necessary for creating py_test cases o/w if we explicitly add
# "//examples/helloworld/proto:py" in the 'deps' list then bazel complains with:
# "'//examples/helloworld/proto:py' does not have mandatory provider 'py'".
# It's also useful for packaging all the server code in a lib to reuse for the :greeter_server.
py_library(
    name = "grpc_server",
    srcs = [
        "greeter_server.py",
    ],
    deps = [
        "//examples/helloworld/proto:py",
        requirement("grpcio"),
        requirement("protobuf"),
    ],
)
