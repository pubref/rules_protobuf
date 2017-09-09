package(default_visibility = ["//visibility:public"])

cc_test(
    name = "test",
    size = "small",
    srcs = ["greeter_client_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    tags = ["exclusive"],
    deps = [
        ":clientlib",
        "@com_google_googletest//:gtest",
    ],
)

cc_binary(
    name = "client",
    srcs = ["greeter_client_main.cc"],
    deps = [":clientlib"],
)

cc_binary(
    name = "server",
    srcs = ["greeter_server.cc"],
    deps = ["//examples/helloworld/proto:cpp"],
)

cc_library(
    name = "clientlib",
    srcs = ["greeter_client.cc"],
    hdrs = ["greeter_client.h"],
    deps = ["//examples/helloworld/proto:cpp"],
)
