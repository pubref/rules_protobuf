load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_library")
load("//protobuf:rules.bzl",
     "proto_compile",
     "proto_repositories")

def closure_proto_repositories(
    lang_requires = [
    ],
    **kwargs):
  proto_repositories(lang_requires = lang_requires, **kwargs)

def closure_proto_compile(langs = [str(Label("//closure"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

def closure_proto_library(
    name,
    langs = [str(Label("//closure"))],
    protos = [],
    imports = [],
    includes = [],
    excludes = [],
    inputs = [],
    output_to_workspace = False,
    proto_deps = [],
    protoc = None,
    pb_plugin = None,
    pb_options = [],
    proto_compile_args = {},
    srcs = [],
    deps = [],
    verbose = 0,
    **kwargs):

  proto_compile_args += {
    "name": name + ".pb",
    "protos": protos,
    "deps": [dep + ".pb" for dep in proto_deps],
    "langs": langs,
    "imports": imports,
    "inputs": inputs,
    "includes": includes,
    "excludes": excludes,
    "pb_options": pb_options,
    "output_to_workspace": output_to_workspace,
    "verbose": verbose,
  }

  if protoc:
    proto_compile_args["protoc"] = protoc
  if pb_plugin:
    proto_compile_args["pb_plugin"] = pb_plugin

  proto_compile(**proto_compile_args)

  closure_js_library(
    name = name,
    internal_descriptors = [name + ".pb.descriptor_set"],
    srcs = srcs + [name + ".pb"],
    deps = depset(deps + proto_deps + [
      "@io_bazel_rules_closure//closure/protobuf:jspb",
    ]).to_list(),
    suppress = [
      "JSC_IMPLICITLY_NULLABLE_JSDOC",
    ],
    **kwargs)
