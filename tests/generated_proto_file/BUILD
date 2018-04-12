package(default_visibility = ["//visibility:public"])

load("//cpp:rules.bzl", "cpp_proto_library")
load("//go:rules.bzl", "go_proto_library")

genrule(
     name = "copy_file",
     srcs = ["simple.proto"],
     outs = ["copy.proto"],
     cmd = "cat $(location simple.proto) > $@",
     message = "copy",
)

cpp_proto_library(
   name = "default_library",
   protos = ["simple.proto"],
   verbose = 0,
)

cpp_proto_library(
   name = "copy_library",
   protos = ["copy.proto"],   
   with_grpc = True,
   verbose = 0,
)

go_proto_library(
   name = "go_default_library",
   protos = ["simple.proto"],
)

go_proto_library(
   name = "go_copy_library",
   protos = ["copy.proto"],
   with_grpc = True,
)

cpp_proto_library(
   name = "subdir_default_library",
   protos = ["subdir/simple.proto"],
   verbose = 0,
)

genrule(
     name = "subdir_copy_proto",
     srcs = ["subdir/simple.proto"],
     outs = ["subdir/copy.proto"],
     cmd = "cat $< > $@",
     message = "copy",
)

cpp_proto_library(
   name = "subdir_copy_library",
   protos = [":subdir_copy_proto"],
   with_grpc = True,
   verbose = 0,
)

genrule(
     name = "complicated_copy_proto",
     srcs = ["complicated/complicated.proto"],
     outs = ["complicated/comp_copy.proto"],
     cmd = "cat $< > $@",
     message = "copy",
)

genrule(
     name = "complicated_copy_proto_copy",
     srcs = ["complicated/complicated_copy.proto"],
     outs = ["complicated/comp_copy2.proto"],
     cmd = "cat $< > $@",
     message = "copy",
)

cpp_proto_library(
   name = "complicated_default_library",
   protos = ["complicated/complicated.proto"],
   verbose = 0,
   proto_deps = [
      ":subdir_default_library",
   ],
   inputs = [
      "@com_google_protobuf//:well_known_protos",
   ],
)

cpp_proto_library(
   name = "complicated_default_library_on_gen",
   protos = ["complicated/complicated_copy.proto"],
   verbose = 0,
   proto_deps = [
      ":subdir_copy_library",
   ],
)

cpp_proto_library(
   name = "complicated_copy_library",
   protos = [":complicated_copy_proto"],
   verbose = 0,
   proto_deps = [
      ":subdir_default_library",
   ],
)

cpp_proto_library(
   name = "complicated_copy_library_on_gen",
   protos = [":complicated_copy_proto_copy"],
   verbose = 0,
   proto_deps = [
      ":subdir_copy_library",
   ],
)