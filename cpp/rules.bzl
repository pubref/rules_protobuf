load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")
load("//cpp:deps.bzl", "DEPS")
load("//cpp:grpc_archive.bzl", "grpc_archive")

def cpp_proto_repositories(
    lang_deps = DEPS,
    lang_requires = [
      "com_google_grpc",
      "com_github_cares_cares",
      "com_google_googletest",
      "com_github_madler_zlib",
      "cares",
      "zlib",
      "nanopb",
      "boringssl",
      "libssl",
      "protoc_gen_grpc_cpp",
    ], **kwargs):

  rem = proto_repositories(lang_deps = lang_deps,
                           lang_requires = lang_requires,
                           **kwargs)

  for dep in rem:
    rule = dep.pop("rule")
    if "grpc_archive" == rule:
      grpc_archive(**dep)
    else:
      fail("Unknown loading rule %s for %s" % (rule, dep))

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
    langs = [str(Label("//cpp"))],
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
    deps = depset(deps + proto_deps + compile_deps).to_list(),
    **kwargs)

# Alias for cpp_proto_library
cc_proto_library = cpp_proto_library
