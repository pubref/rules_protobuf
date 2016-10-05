load("@io_bazel_rules_go//go:def.bzl", "go_library")
load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")

def go_proto_repositories(
    lang_requires = [
      "protobuf",
      "external_protoc",
      "com_github_golang_protobuf",
      "com_github_golang_glog",
      "org_golang_google_grpc",
      "org_golang_x_net",
    ], **kwargs):
  proto_repositories(lang_requires = lang_requires, **kwargs)


PB_COMPILE_DEPS = [
    "@com_github_golang_protobuf//proto:go_default_library",
]

GRPC_COMPILE_DEPS = PB_COMPILE_DEPS + [
    "@com_github_golang_glog//:go_default_library",
    "@org_golang_google_grpc//:go_default_library",
    "@org_golang_x_net//context:go_default_library",
]


def go_proto_compile(langs = [str(Label("//go"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

def go_proto_library(
    name,
    langs = [str(Label("//go"))],
    protos = [],
    imports = [],
    inputs = [],
    proto_deps = [],
    output_to_workspace = False,
    protoc = None,

    pb_plugin = None,
    pb_options = [],

    grpc_plugin = None,
    grpc_options = [],

    proto_compile_args = {},
    with_grpc = True,
    srcs = [],
    deps = [],
    go_proto_deps = [],
    verbose = 0,
    **kwargs):

  if not go_proto_deps:
    if with_grpc:
      go_proto_deps += GRPC_COMPILE_DEPS
    else:
      go_proto_deps += PB_COMPILE_DEPS

  proto_compile_args += {
    "name": name + ".pb",
    "protos": protos,
    "deps": [dep + ".pb" for dep in proto_deps],
    "langs": langs,
    "imports": imports,
    "inputs": inputs,
    "pb_options": pb_options,
    "grpc_options": grpc_options,
    "output_to_workspace": output_to_workspace,
    "verbose": verbose,
  }

  if protoc:
    proto_compile_args["protoc"] = protoc
  if pb_plugin:
    proto_compile_args["pb_plugin"] = pb_plugin
  if grpc_plugin:
    proto_compile_args["grpc_plugin"] = grpc_plugin

  proto_compile(**proto_compile_args)

  go_library(
    name = name,
    srcs = srcs + [name + ".pb"],
    deps = list(set(deps + proto_deps + go_proto_deps)),
    **kwargs)
