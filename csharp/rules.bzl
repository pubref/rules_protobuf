load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "nuget_package", "new_nuget_package", "csharp_library", "dll_import")
load("//protobuf:rules.bzl", "proto_compile", "proto_repositories", "proto_language_deps")


def csharp_proto_repositories():
  proto_repositories()

  new_nuget_package(
    name = "nuget_google_protobuf",
    package = "Google.Protobuf",
    version = "3.0.0",
    build_file_content =
"""
load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "dll_import")
dll_import(
  name = "libnet45",
  srcs = [
    "Google.Protobuf.3.0.0/lib/net45/Google.Protobuf.dll",
  ],
  visibility = ["//visibility:public"],
)
"""
  )

  new_nuget_package(
    name = "nuget_grpc",
    package = "Grpc",
    version = "1.0.0",
    build_file_content =
"""
load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "dll_import")
dll_import(
  name = "runtime_osx",
  srcs = glob(["Grpc.Core.1.0.0/runtimes/osx/**/*.dll"]),
  visibility = ["//visibility:public"],
)
dll_import(
  name = "system_interactive_async",
  srcs = glob(["System.Interactive.Async.3.0.0/lib/net45/**/*.dll"]),
  visibility = ["//visibility:public"],
)
dll_import(
  name = "core",
  srcs = glob(["Grpc.Core.1.0.0/lib/net45/**/*.dll"]),
  visibility = ["//visibility:public"],
)
"""
  )

  new_nuget_package(
    name = "nuget_grpc_tools",
    package = "Grpc.Tools",
    version = "1.0.0",
    build_file_content =
"""
load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "dll_import", "csharp_binary")
genrule(
  name = "protoc-gen-grpc-csharp_bin",
  srcs = [":grpc_csharp_plugin"],
  outs = ["protoc-gen-grpc-csharp"],
  cmd = "cp $(location :grpc_csharp_plugin) $$(pwd)/$@",
  executable = True,
  visibility = ["//visibility:public"],
)
filegroup(
  name = "grpc_csharp_plugin",
  srcs = select({
    ":darwin": ["Grpc.Tools.1.0.0/tools/macosx_x64/grpc_csharp_plugin"],
    "//conditions:default": ["Grpc.Tools.1.0.0/tools/linux_x64/grpc_csharp_plugin"],
  }),
)
config_setting(
    name = "darwin",
    values = {"cpu": "darwin"},
    visibility = ["//visibility:private"],
)
"""
  )

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
    "with_grpc": with_grpc,
    "verbose": verbose,
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
    #deps = list(set(deps + proto_deps + [name + "_imports"])),
    deps = list(set(deps + proto_deps + compile_deps)),
    **kwargs)
