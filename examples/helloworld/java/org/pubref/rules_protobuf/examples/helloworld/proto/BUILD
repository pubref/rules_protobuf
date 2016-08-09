package(default_visibility = ["//visibility:public"])

load("//bzl:java/class.bzl", JAVA = "CLASS")
load("//bzl:java/rules.bzl", "java_proto_library", "java_proto_compile")

java_proto_compile(
    name = "proto",
    protos = ["//examples/helloworld/proto:srcs"],
    gen_java = True,
    gen_grpc_java = True,
)

# java_proto_library(
#     name = "protolib",
#     protos = ["//examples/helloworld/proto:srcs"],
#     with_grpc = True,
# )

java_library(
    name = "protolib",
    srcs = [
        ":proto",
    ],
    deps = JAVA.protobuf.compile_deps + JAVA.grpc.compile_deps,
)
