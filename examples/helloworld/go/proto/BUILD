package(default_visibility = ["//visibility:public"])

load("//bzl:rules.bzl", "protoc_go")

protoc_go(
    name = "proto",
    srcs = ["helloworld.proto"],
    import_map = {
        "examples/helloworld/go/proto/helloworld.proto": "pubref.org/rules_pubref/examples/helloworld",
    },
    with_grpc = True,
    verbose = True,
)
