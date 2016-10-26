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
