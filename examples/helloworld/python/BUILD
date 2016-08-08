package(default_visibility = ["//visibility:public"])

#load("//bzl:rules.bzl", "protoc_py")
load("//bzl:protobuf.bzl", "proto_compile")

# protoc_py(
#     name = "proto",
#     srcs = ["//examples/helloworld/proto:srcs"],
#     verbose = 0,
#     with_grpc = True,
# )

# protobuf_py(
#     name = "protobuf",
#     srcs = ["//examples/helloworld/proto:srcs"],
#     verbose = 1,
#     with_grpc = True,
# )

proto_compile(
    name = "protos",
    srcs = ["//examples/helloworld/proto:srcs"],
    verbose = 1,
    gen_py = True,
    gen_ruby = True,
    gen_go = True,
    gen_cpp = True,
    with_grpc = True,
)

# py_protobuf_generate(
#     name = "client",
#     srcs = [
#         "client.py",
#         ":proto",
#     ],
# )
