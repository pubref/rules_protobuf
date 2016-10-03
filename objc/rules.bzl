load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")

def objc_proto_repositories(
    lang_requires = [
      "grpc",
      "external_protobuf_compiler",
      "external_protoc_gen_grpc_objc",
    ], **kwargs):
  proto_repositories(lang_requires = lang_requires, **kwargs)

PB_COMPILE_DEPS = [
    "@com_github_google_protobuf//:protobuf_objc",
]

GRPC_COMPILE_DEPS = PB_COMPILE_DEPS + [
    "@com_github_grpc_grpc//:grpc_objc",
]

def objc_proto_compile(langs = [str(Label("//objc"))], **kwargs):
  proto_compile(langs = langs, **kwargs)


def objc_proto_library(
    name,
    langs = [str(Label("//objc"))],
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
    verbose = 0,
    **kwargs):

  if with_grpc:
    compile_deps = GRPC_COMPILE_DEPS
  else:
    compile_deps = PB_COMPILE_DEPS

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

  native.objc_library(
    name = name,
    srcs = srcs + [name + ".pb"],
    deps = list(set(deps + proto_deps + compile_deps)),
    **kwargs)
