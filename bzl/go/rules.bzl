load("//bzl:protoc.bzl", "implement", "EXECUTABLE")
load("//bzl:go/class.bzl", GO = "CLASS")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

go_proto_compile = implement([GO.name])

def go_proto_library(
    name,
    copy_protos_to_genfiles = True,
    deps = [],
    grpc_plugin = None,
    grpc_plugin_options = [],
    imports = [],
    lang = GO,
    protobuf_plugin_options = [],
    protobuf_plugin = None,
    proto_compile = go_proto_compile,
    protoc = EXECUTABLE,
    srcs = [],
    verbose = 0,
    visibility = None,
    with_grpc = False,
    go_deps = [],
    go_srcs = [],
    **kwargs):

  args = {}
  args["name"] = name + ".pb"
  args["copy_protos_to_genfiles"] = copy_protos_to_genfiles
  args["deps"] = [d + ".pb" for d in deps]
  args["imports"] = imports
  args["gen_" + lang.name] = True
  args["gen_grpc_" + lang.name] = with_grpc
  args["gen_protobuf_" + lang.name + "_plugin"] = protobuf_plugin
  args["gen_" + lang.name + "_plugin_options"] = protobuf_plugin_options
  args["gen_grpc_" + lang.name + "_plugin"] = grpc_plugin
  args["protoc"] = protoc
  args["protos"] = srcs
  args["verbose"] = verbose
  args["with_grpc"] = with_grpc

  proto_compile(**args)

  if with_grpc and hasattr(lang, "grpc"):
    deps += [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]
  elif hasattr(lang, "protobuf"):
    deps += [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]

  deps = list(set(deps + go_deps))

  go_library(
     name = name,
     srcs = go_srcs + [ name + ".pb"],
     deps = deps,
     **kwargs
  )
