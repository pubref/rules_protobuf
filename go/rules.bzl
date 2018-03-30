load("@io_bazel_rules_go//go:def.bzl", "go_library", "go_repository")
load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")
load("//go:deps.bzl", "DEPS")

def go_proto_repositories(
    lang_deps = DEPS,
    lang_requires = [
      "com_github_golang_protobuf",
      "com_github_golang_glog",
      "org_golang_google_grpc",
      "org_golang_google_genproto",
      "org_golang_x_net",
      "org_golang_x_text",
    ], **kwargs):

  rem = proto_repositories(lang_deps = lang_deps,
                           lang_requires = lang_requires,
                           **kwargs)

  # Load remaining (special) deps
  for dep in rem:
    rule = dep.pop("rule")
    if "go_repository" == rule:
      go_repository(**dep)
    else:
      fail("Unknown loading rule %s for %s" % (rule, dep))


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
    go_prefix = Label("//:go_prefix", relative_to_caller_repository=True),
    importpath = None,
    go_package = None,
    protos = [],
    importmap = {},
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

  resolved_go_proto_deps = [] + go_proto_deps
  if not go_proto_deps:
    if with_grpc:
      resolved_go_proto_deps = GRPC_COMPILE_DEPS
    else:
      resolved_go_proto_deps = PB_COMPILE_DEPS

  if importpath:
    go_prefix = None

  proto_compile_args += {
    "name": name + ".pb",
    "protos": protos,
    "go_prefix": go_prefix,
    "go_importpath": importpath,
    "go_package": go_package,
    "deps": [dep + ".pb" for dep in proto_deps],
    "langs": langs,
    "importmap": importmap,
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
    deps = depset(deps + proto_deps + resolved_go_proto_deps).to_list(),
    importpath = importpath,
    **kwargs)
