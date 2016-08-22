load("//bzl:protoc.bzl", "implement", "EXECUTABLE")
load("//bzl:go/class.bzl", GO = "CLASS")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

go_proto_compile = implement(["go"])

def go_proto_library(
    name,
    protos,
    copy_protos_to_genfiles = True,
    deps = [],
    grpc_plugin = None,
    grpc_plugin_options = [],
    imports = [],
    lang = GO,
    proto_compile = go_proto_compile,
    protobuf_plugin_options = [],
    protobuf_plugin = None,
    protoc = EXECUTABLE,
    srcs = [],
    verbose = 0,
    visibility = None,
    with_grpc = False,
    **kwargs):

  args = {}
  args["name"] = name + "_pb"
  args["copy_protos_to_genfiles"] = copy_protos_to_genfiles
  args["deps"] = deps
  args["imports"] = imports
  args["gen_" + lang.name] = True
  args["gen_grpc_" + lang.name] = with_grpc
  args["gen_protobuf_" + lang.name + "_plugin"] = protobuf_plugin
  args["gen_" + lang.name + "_plugin_options"] = protobuf_plugin_options
  args["gen_grpc_" + lang.name + "_plugin"] = grpc_plugin
  args["protoc"] = protoc
  args["protos"] = protos
  args["verbose"] = verbose
  args["with_grpc"] = with_grpc

  proto_compile(**args)

  if with_grpc and hasattr(lang, "grpc"):
    proto_deps = [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]
  elif hasattr(lang, "protobuf"):
    proto_deps = [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]

  go_deps = list(set(deps + proto_deps))

  go_library(
     name = name,
     srcs = srcs + [ name + "_pb"],
     deps = go_deps,
     **kwargs
  )
