load("@io_bazel_rules_go//go:def.bzl", "go_library")
load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")
load("//go:rules.bzl", "go_proto_repositories")
load("//go:deps.bzl", GO_DEPS = "DEPS")
load("//gogo:deps.bzl", GOGO_DEPS = "DEPS")

def gogo_proto_repositories(
    lang_deps = GO_DEPS + GOGO_DEPS,
    lang_requires = [
      "com_github_golang_protobuf",
      "com_github_golang_glog",
      "org_golang_google_grpc",
      "org_golang_x_net",
      "com_github_gogo_protobuf",
    ], **kwargs):

  go_proto_repositories(lang_deps = lang_deps,
                        lang_requires = lang_requires,
                        **kwargs)

PB_COMPILE_DEPS = [
  "@com_github_gogo_protobuf//proto:go_default_library",
]

GRPC_COMPILE_DEPS = PB_COMPILE_DEPS + [
  "@com_github_golang_glog//:go_default_library",
  "@org_golang_google_grpc//:go_default_library",
  "@org_golang_x_net//context:go_default_library",
]


def gogo_proto_compile(langs = [str(Label("//gogo"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

def gogofast_proto_compile(langs = [str(Label("//gogo:gogofast"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

def gogofaster_proto_compile(langs = [str(Label("//gogo:gogofaster"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

def gogoslick_proto_compile(langs = [str(Label("//gogo:gogoslick"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

def gogofast_proto_library(
    name,
    langs = [str(Label("//gogo:gogofast"))],
    protos = [],
    importmap = {},
    importpath = None,
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
  gogo_proto_library(name, langs, protos, importmap, importpath, imports, inputs, proto_deps, output_to_workspace, protoc, pb_plugin, pb_options, grpc_plugin, grpc_options, proto_compile_args, with_grpc, srcs, deps, go_proto_deps, verbose, **kwargs)

def gogofaster_proto_library(
    name,
    langs = [str(Label("//gogo:gogofaster"))],
    protos = [],
    importmap = {},
    importpath = None,
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
  gogo_proto_library(name, langs, protos, importmap, importpath, imports, inputs, proto_deps, output_to_workspace, protoc, pb_plugin, pb_options, grpc_plugin, grpc_options, proto_compile_args, with_grpc, srcs, deps, go_proto_deps, verbose, **kwargs)

def gogoslick_proto_library(
    name,
    langs = [str(Label("//gogo:gogoslick"))],
    protos = [],
    importmap = {},
    importpath = None,
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
  gogo_proto_library(name, langs, protos, importmap, importpath, imports, inputs, proto_deps, output_to_workspace, protoc, pb_plugin, pb_options, grpc_plugin, grpc_options, proto_compile_args, with_grpc, srcs, deps, go_proto_deps, verbose, **kwargs)

def gogo_proto_library(
    name,
    langs = [str(Label("//gogo"))],
    protos = [],
    importmap = {},
    importpath = None,
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

  gogo_proto_deps = [] + go_proto_deps
  
  if not go_proto_deps:
    if with_grpc:
      gogo_proto_deps += GRPC_COMPILE_DEPS
    else:
      gogo_proto_deps += PB_COMPILE_DEPS

  proto_compile_args += {
    "name": name + ".pb",
    "protos": protos,
    "deps": [dep + ".pb" for dep in proto_deps],
    "langs": langs,
    "importmap": importmap,
    "go_importpath": importpath,
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

  go_library(
    name = name,
    srcs = srcs + [name + ".pb"],
    deps = depset(deps + proto_deps + gogo_proto_deps).to_list(),
    importpath = importpath,
    **kwargs)
