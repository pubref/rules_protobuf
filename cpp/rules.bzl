load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")
load("//cpp:deps.bzl", "DEPS")

def cpp_proto_repositories(
    lang_deps = DEPS,
    lang_requires = [
      "protobuf",
      "protobuf_clib",
      "gtest",
      "com_github_madler_zlib",
      "cares",
      "zlib",
      "nanopb",
      "boringssl",
      "libssl",
      "protocol_compiler",
      "protoc_gen_grpc_cpp",
    ], **kwargs):

  proto_repositories(lang_deps = lang_deps,
                     lang_requires = lang_requires,
                     **kwargs)

PB_COMPILE_DEPS = [
    "//external:protobuf_clib",
]

GRPC_COMPILE_DEPS = PB_COMPILE_DEPS + [
    "@com_google_grpc//:grpc++",
    "@com_google_grpc//:grpc++_reflection",
]

def cpp_proto_compile(langs = [str(Label("//cpp"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

cc_proto_compile = cpp_proto_compile

def cpp_proto_library(
    name,
    deps = [],
    excludes = None,
    grpc_plugin = None,
    grpc_options = [],
    langs = [str(Label("//cpp"))],
    imports = [],
    inputs = [],
    includes = [],
    pb_plugin = None,
    pb_options = [],
    pre_commands = None,
    proto_compile_args = {},
    proto_deps = [],
    protoc = None,
    protos = [],
    root = None,
    srcs = [],
    output_to_workspace = False,
    verbose = 0,
    with_grpc = True,
    **kwargs):

  if with_grpc:
    compile_deps = GRPC_COMPILE_DEPS
  else:
    compile_deps = PB_COMPILE_DEPS

  proto_compile_args += {
    "name": name + ".pb",
    "pre_commands": pre_commands,
    "deps": [dep + ".pb" for dep in proto_deps],
    "excludes": excludes,
    "grpc_options": grpc_options,
    "imports": imports,
    "includes": includes,
    "inputs": inputs,
    "langs": langs,
    "pb_options": pb_options,
    "protos": protos,
    "root": root,
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

  native.cc_library(
    name = name,
    srcs = srcs + [name + ".pb"],
    deps = list(set(deps + proto_deps + compile_deps)),
    **kwargs)

# Alias for cpp_proto_library
cc_proto_library = cpp_proto_library
