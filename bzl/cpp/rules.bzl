load("//bzl:protoc.bzl", "implement", "PROTOC")
load("//bzl:util.bzl", "invoke")
load("//bzl:cpp/class.bzl", CPP = "CLASS")

cc_proto_compile = implement([CPP.name])

def cc_proto_library(
    name,
    copy_protos_to_genfiles = False,
    deps = [],
    grpc_plugin = None,
    grpc_plugin_options = [],
    imports = [],
    lang = CPP,
    protobuf_plugin_options = [],
    protobuf_plugin = None,
    proto_compile = cc_proto_compile,
    protoc = PROTOC,
    srcs = [],
    verbose = 0,
    visibility = None,
    with_grpc = False,
    cc_deps = [],
    cc_srcs = [],
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

  deps = list(set(deps + cc_deps))

  native.cc_library(
    name = name,
    srcs = cc_srcs + [name + ".pb"],
    deps = deps,
    **kwargs
  )
