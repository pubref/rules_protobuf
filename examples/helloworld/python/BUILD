package(default_visibility = ["//visibility:public"])

# Note: python grpc functionality in rules_protobuf is very
# experimental.  There is currently no support for fetching the
# platform-specific grpcio wheel from pypi within bazel.  To try this,
# you'll have to `pip install grpcio` locally so it's available for
# import.

py_binary(
    name = "greeter_client",
    srcs = [
        "greeter_client.py",
        "//examples/proto:py",
        "//examples/helloworld/proto:py",
    ],
)

py_binary(
    name = "greeter_server",
    srcs = [":grpc_server"],
)

py_test(
    name = "test_greeter_server",
    srcs = ["test_greeter_server.py"],
    deps = [":grpc_server"]
)

# This library is necessary for creating py_test cases o/w if we explicitly add
# "//examples/helloworld/proto:py" in the 'deps' list then bazel complains with:
# "'//examples/helloworld/proto:py' does not have mandatory provider 'py'".
# It's also useful for packaging all the server code in a lib to reuse for the :greeter_server.
py_library(
    name = "grpc_server",
    srcs = [
        "greeter_server.py",
        "//examples/proto:py",
        "//examples/helloworld/proto:py",
    ]
)