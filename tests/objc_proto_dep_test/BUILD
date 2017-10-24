package(default_visibility = ["//visibility:public"])

load("//objc:rules.bzl", "objc_proto_library")

objc_proto_library(
   name = "lib1",
   protos = ["lib1.proto"],
   with_grpc = False,
)

objc_proto_library(
   name = "lib2",
   protos = ["lib2.proto"],
   proto_deps = [":lib1"],   
   imports = ["."],
   with_grpc = False,
)

