package(default_visibility = ["//visibility:public"])

load("//go:rules.bzl", "go_proto_library")

genrule(
     name = "copy_file",
     srcs = ["simple.proto"],
     outs = ["copy.proto"],
     cmd = "cat $(location simple.proto) > $@",
     message = "copy",
)

go_proto_library(
   name = "go_default_library",
   protos = ["simple.proto"],
   importpath = "github.com/pubref/rules_protobuf/tests/generated_proto_file/go_default_library",
)

go_proto_library(
   name = "go_copy_library",
   protos = ["copy.proto"],
   with_grpc = True,
   importpath = "github.com/pubref/rules_protobuf/tests/generated_proto_file/go_copy_library",
)

genrule(
     name = "subdir_copy_proto",
     srcs = ["subdir/simple.proto"],
     outs = ["subdir/copy.proto"],
     cmd = "cat $< > $@",
     message = "copy",
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
