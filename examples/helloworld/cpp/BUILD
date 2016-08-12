package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library", "cc_proto_compile")
load(
    "//bzl:cpp/class.bzl",
    CPP = "CLASS",
)

# This won't work from here, becuase macros don't do well with non
# non-label lists.
# cc_proto_library(
#     name = 'protolib',
#     protos = [
#         '//examples/helloworld/proto:srcs',
#     ],
#     with_grpc = True,
#     verbose = 1,
#     linkopts = ['-ldl'],
# )

# cc_proto_compile(
#     name = 'protos',
#     protos = [
#         '//examples/helloworld/proto:srcs',
#     ],
#     with_grpc = True,
#     linkopts = ['-ldl'],
# )

cc_test(
    name = "test",
    srcs = ["greeter_client_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    linkopts = ["-ldl"],
    deps = [
        ":clientlib",
        "@gtest//:main",
    ],
)

cc_library(
    name = "clientlib",
    srcs = [
        "greeter_client.cc",
    ],
    hdrs = [
        "greeter_client.h",
    ],
    linkopts = ["-ldl"],
    deps = [
        "//examples/helloworld/proto:cpp",
    ],
)

cc_binary(
    name = "client",
    deps = [
        ":clientlib",
    ],
)

# cc_binary(
#     name = "client_from_source",
#     srcs = [
#         "greeter_client.cc",
#         "greeter_client.h",
#         "//examples/helloworld/proto:cpp_pb",
#     ],
#     linkopts = ["-ldl"],
#     deps = CPP.grpc.compile_deps,
# )

cc_binary(
    name = "server",
    srcs = [
        "greeter_server.cc",
    ],
    linkopts = ["-ldl"],
    deps = [
        "//examples/helloworld/proto:cpp",
    ],
)
