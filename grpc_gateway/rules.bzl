load("@io_bazel_rules_go//go:def.bzl", "go_library", "go_binary")
load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")
load("//go:rules.bzl", "PB_COMPILE_DEPS", "GRPC_COMPILE_DEPS", "go_proto_repositories")
load("//grpc_gateway:deps.bzl", "DEPS")

def grpc_gateway_proto_repositories(
    lang_deps = DEPS,
    lang_requires = [
      "com_github_grpc_ecosystem_grpc_gateway",
      "com_github_grpc_ecosystem_grpc_gateway_googleapis",
      "org_golang_google_genproto",
    ], **kwargs):

  go_proto_repositories(lang_deps = lang_deps,
                        lang_requires = lang_requires,
                        **kwargs)

GRPC_GATEWAY_DEPS = [
  "@com_github_grpc_ecosystem_grpc_gateway//runtime:go_default_library",
  "@com_github_grpc_ecosystem_grpc_gateway//utilities:go_default_library",
  "@org_golang_google_genproto//googleapis/api/annotations:go_default_library",
  "@org_golang_google_grpc//codes:go_default_library",
  "@org_golang_google_grpc//grpclog:go_default_library",
  "@org_golang_google_grpc//:go_default_library",
  "@org_golang_google_grpc//status:go_default_library",
  "@org_golang_x_net//context:go_default_library",
  "@com_github_golang_glog//:go_default_library",
  "@com_github_ghodss_yaml//:go_default_library",
]

def grpc_gateway_proto_library(
    name,
    pb_gateway = str(Label("//grpc_gateway:pb_gateway")),
    langs = [str(Label("//grpc_gateway"))],
    protos = [],
    imports = [],
    importmap = {},
    inputs = [],
    proto_deps = [],
    output_to_workspace = False,
    protoc = None,
    pb_plugin = None,
    pb_options = [],
    grpc_plugin = None,
    grpc_options = [],
    pb_args = {},
    pbgw_args = {},
    srcs = [],
    deps = [],
    go_proto_deps = [],
    grpc_gateway_deps = GRPC_GATEWAY_DEPS,
    verbose = 0,

    logtostderr = False,
    alsologtostderr = False,
    log_backtrace_at = None,
    stderrthreshold = None,
    log_dir = None,
    log_level = None,
    import_prefix = None,
    request_context = False,

    **kwargs):

  _go_proto_deps = [] + go_proto_deps
  
  if not go_proto_deps:
    _go_proto_deps += GRPC_COMPILE_DEPS

  pb_args += {
    "name": name + ".pb",
    "protos": protos,
    "deps": [dep + ".pb" for dep in proto_deps],
    "langs": [pb_gateway],
    "imports": imports,
    "importmap": importmap,
    "inputs": inputs,
    "pb_options": pb_options,
    "grpc_options": grpc_options,
    "output_to_workspace": output_to_workspace,
    "verbose": verbose,
  }

  if protoc:
    pb_args["protoc"] = protoc
  if pb_plugin:
    pb_args["pb_plugin"] = pb_plugin
  if grpc_plugin:
    pb_args["grpc_plugin"] = grpc_plugin

  proto_compile(**pb_args)

  pbgw_opts = []
  if logtostderr:
    pbgw_opts += ["logtostderr=true"]
  if alsologtostderr:
    pbgw_opts += ["alsologtostderr=true"]
  if log_backtrace_at:
    pbgw_opts += ["log_backtrace_at=%s" % log_backtrace_at]
  if stderrthreshold:
    pbgw_opts += ["stderrthreshold=%s" % stderrthreshold]
  if log_dir:
    pbgw_opts += ["log_dir=%s" % log_dir]
  if log_level:
    pbgw_opts += ["v=%s" % log_level]
  if import_prefix:
    pbgw_opts += ["import_prefix=%s" % import_prefix]
  if request_context:
    pbgw_opts += ["request_context=true"]

  pbgw_args += {
    "name": name + ".gw",
    "protos": protos,
    "deps": [dep + ".pb" for dep in proto_deps],
    "langs": langs,
    "imports": imports,
    "importmap": importmap,
    "inputs": inputs,
    "pb_options": pb_options,
    "grpc_options": grpc_options + pbgw_opts,
    "output_to_workspace": output_to_workspace,
    "verbose": verbose,
  }

  proto_compile(**pbgw_args)

  go_library(
    name = name,
    srcs = srcs + [name + ".pb"] + [name + ".gw"],
    deps = depset(deps + proto_deps + _go_proto_deps + grpc_gateway_deps).to_list(),
    **kwargs)


def grpc_gateway_proto_compile(langs = [str(Label("//grpc_gateway"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

def grpc_gateway_swagger_compile(langs = [str(Label("//grpc_gateway:swagger"))], **kwargs):
  proto_compile(langs = langs, with_grpc = False, **kwargs)

def grpc_gateway_binary(name,
                        srcs = [],
                        deps = [],
                        protos = [],
                        proto_label = "go_default_library",
                        proto_deps = [],
                        grpc_gateway_deps = GRPC_GATEWAY_DEPS,
                        **kwargs):

  grpc_gateway_proto_library(
    name = proto_label,
    protos = protos,
    proto_deps = proto_deps,
     **kwargs
  )

  go_binary(
     name = name,
     srcs = srcs,
     deps = deps + [proto_label] + grpc_gateway_deps,
  )
