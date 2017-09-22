load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "nuget_package", "new_nuget_package", "csharp_library", "dll_import")
load("//protobuf:rules.bzl", "proto_compile", "proto_repositories", "proto_language_deps")
load("//cpp:rules.bzl", "cpp_proto_repositories")
load("//csharp:deps.bzl", "DEPS")

def csharp_proto_repositories(
    omit_cpp_repositories = False,
    lang_deps = DEPS,
    lang_requires = [
      "protoc_gen_grpc_csharp",
      "nuget_google_protobuf",
      "nuget_grpc",
    ], **kwargs):

  if not omit_cpp_repositories:
    cpp_proto_repositories()

  rem = proto_repositories(lang_deps = lang_deps,
                           lang_requires = lang_requires,
                           **kwargs)

  # Load remaining (nuget) deps
  for dep in rem:
    rule = dep.pop("rule")
    if "new_nuget_package" == rule:
      new_nuget_package(**dep)
    else:
      fail("Unknown loading rule %s for %s" % (rule, dep))

PB_COMPILE_DEPS = [
  "@nuget_google_protobuf//:libnet45",
]

GRPC_COMPILE_DEPS = PB_COMPILE_DEPS + [
  "@nuget_grpc//:core",
]

def csharp_proto_compile(langs = [str(Label("//csharp"))], **kwargs):
  proto_compile(langs = langs, **kwargs)


def csharp_proto_library(
    name,
    langs = [str(Label("//csharp"))],
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
    with_grpc = False,
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

  # proto_language_deps(
  #   name = name + "_deps",
  #   langs = langs,
  #   file_extensions = [".dll"],
  #   with_grpc = with_grpc,
  # )

  # dll_import(
  #   name = name + "_imports",
  #   srcs = [name + "_deps"],
  # )

  if with_grpc:
    compile_deps = GRPC_COMPILE_DEPS
  else:
    compile_deps = PB_COMPILE_DEPS

  csharp_library(
    name = name,
    srcs = srcs + [name + ".pb"],
    #deps = depset(deps + proto_deps + [name + "_imports"]).to_list(),
    deps = depset(deps + proto_deps + compile_deps).to_list(),
    **kwargs)
