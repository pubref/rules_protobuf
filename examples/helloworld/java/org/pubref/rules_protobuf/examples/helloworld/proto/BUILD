package(default_visibility = ["//visibility:public"])

load("//bzl:java/rules.bzl", "java_proto_library", "java_proto_compile")

java_proto_library(
    name = "proto",
    protos = ["//examples/helloworld/proto:srcs"],
    verbose = 0,
    with_grpc = True,
)

java_proto_compile(
    name = "srcs",
    protos = ["//examples/helloworld/proto:srcs"],
    with_grpc = True,
)

#load("//bzl:java/class.bzl", JAVA = "CLASS")
# java_library(
#     name = "protolib2",
#     srcs = [
#         ":proto",
#     ],
#     deps = JAVA.grpc.compile_deps,
# )
