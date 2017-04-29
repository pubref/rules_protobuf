package(default_visibility = ["//visibility:public"])

load("//java:rules.bzl", "java_proto_library")

alias(
  name = 'bottom',
  actual = ':bottom_proto_java',
)

java_proto_library(
    name = "google_well_known_protos",
    protos = ["@com_github_google_protobuf//:well_known_protos"],
    imports = ["src"],
)

java_proto_library(
    name = "bottom_proto_java",
    protos = [":srcs"],
    proto_deps = [
      ":google_well_known_protos",
    ],
)

filegroup(
    name = "srcs",
    srcs = ["examples/proto/bottom.proto"],
)
