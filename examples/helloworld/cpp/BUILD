package(default_visibility = ["//visibility:public"])

load("//bzl:cpp/rules.bzl", "cc_proto_library", "cc_proto_compile")
load("//bzl:cpp/class.bzl", CPP = "CLASS")

cc_test(
    name = "test",
    size = "small",
    srcs = ["greeter_client_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        ":clientlib",
        "@gtest//:main",
    ],
)

cc_library(
    name = "clientlib",
    srcs = ["greeter_client.cc"],
    hdrs = ["greeter_client.h"],
    deps = ["//examples/helloworld/proto:cpp"],
)

cc_binary(
    name = "client",
    srcs = ["greeter_client_main.cc"],
    deps = [":clientlib"],
)

cc_binary(
    name = "server",
    srcs = ["greeter_server.cc",],
    deps = ["//examples/helloworld/proto:cpp"],

    # If this variant is used, the protos in proto:srcs will be copied
    # to the same namespace as the calling build rule (in this case
    # examples/helloworld/cpp) before protoc'ing, affecting the name
    # of the compiled protobuf sources.  In this case the header
    # include statements need to be changed to
    # "examples/helloworld/cpp/helloworld.pb.h"...
    #
    #deps = [":protolib"],
)

cc_proto_library(
    name = 'protolib',
    protos = [
        '//examples/helloworld/proto:srcs',
    ],
    with_grpc = True,
    verbose = 0,
)
