load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")
load("//python:deps.bzl", "DEPS")
load("//cpp:rules.bzl", "cpp_proto_repositories")

def py_proto_repositories(
    omit_cpp_repositories = False,
    lang_deps = DEPS,
    lang_requires = [
      "protoc_gen_grpc_python",
    ], **kwargs):

  if not omit_cpp_repositories:
    cpp_proto_repositories(**kwargs)

  proto_repositories(lang_deps = lang_deps,
                     lang_requires = lang_requires,
                     **kwargs)

def py_proto_compile(langs = [str(Label("//python"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

def py_proto_library(
    name,
    langs = [str(Label("//python"))],
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
    py_proto_deps = [],
    verbose = 0,
    **kwargs):

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
    "with_grpc": with_grpc,
  }

  if protoc:
    proto_compile_args["protoc"] = protoc
  if pb_plugin:
    proto_compile_args["pb_plugin"] = pb_plugin
  if grpc_plugin:
    proto_compile_args["grpc_plugin"] = grpc_plugin

  proto_compile(**proto_compile_args)

  native.py_library(
    name = name,
    srcs = srcs + [name + ".pb"],
    deps = depset(deps + proto_deps).to_list(),
    **kwargs)
