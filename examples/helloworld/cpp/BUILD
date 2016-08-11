package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library", "cc_proto_compile")
load("//bzl:cpp/class.bzl", CPP = "CLASS")

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
    deps = [
        ":clientlib",
        "@gtest//:main",
    ],
    linkopts = ['-ldl'],
    copts = ["-Iexternal/gtest/include"],
)

cc_library(
    name = 'clientlib',
    srcs = [
        'greeter_client.cc',
    ],
    hdrs = [
        'greeter_client.h',
    ],
    deps = [
        "//examples/helloworld/proto:cpp",
    ],
    linkopts = ['-ldl'],
)

cc_binary(
    name = 'client',
    deps = [
        ":clientlib",
    ],
)

cc_binary(
    name = 'client_from_source',
    srcs = [
        'greeter_client.h',
        'greeter_client.cc',
        "//examples/helloworld/proto:cpp_pb",
    ],
    deps = CPP.grpc.compile_deps,
    linkopts = ['-ldl'],
)

cc_binary(
    name = 'server',
    srcs = [
        'greeter_server.cc',
    ],
    deps = [
        "//examples/helloworld/proto:cpp",
    ],
    linkopts = ['-ldl'],
)
