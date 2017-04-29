package(default_visibility = ["//visibility:public"])

load("//java:rules.bzl", "java_proto_library")

alias(
  name = 'top',
  actual = ':top_proto_java',
)

java_proto_library(
    name = "top_proto_java",
    protos = [":srcs"],
    proto_deps = [
      "//tests/transitive_dependencies/middle:middle_proto_java",
    ],
)

filegroup(
  name = "srcs",
  srcs = glob(["**/*.proto"]),
)
