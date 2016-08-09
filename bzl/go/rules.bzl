load("//bzl:protoc.bzl", "protoc")
load("//bzl:go/class.bzl", GO = "CLASS")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

def go_proto_library(
    name,
    protos,
    lang = GO,
    srcs = [],
    imports = [],
    visibility = None,
    testonly = 0,
    protoc_executable = None,
    protobuf_plugin_executable = None,
    with_grpc = False,
    **kwargs):

  result = protoc(
    spec = [lang],
    name = name + "_pb",
    protos = protos,
    protoc_executable = protoc_executable,
    protobuf_plugin_executable = protobuf_plugin_executable,
    visibility = visibility,
    testonly = testonly,
    imports = imports,
    with_grpc = with_grpc,
  )

  deps = [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]
  if with_grpc:
    deps += [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]

  go_library(
    name = name,
    srcs = result.outs,
    deps = deps,
    **kwargs
  )
