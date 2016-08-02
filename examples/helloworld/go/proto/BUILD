package(default_visibility = ["//visibility:public"])

load("//bzl:rules.bzl", "protoc_go")

protoc_go(
    name = "proto",
    srcs = ["//examples/helloworld/proto:srcs"],
    import_map = {
        "examples/helloworld/go/proto/helloworld.proto": "pubref.org/rules_pubref/examples/helloworld",
    },
    with_grpc = True,
    verbose = 1,
)
