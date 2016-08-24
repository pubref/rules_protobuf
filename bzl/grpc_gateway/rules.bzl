load("//bzl:protoc.bzl", "PROTOC", "implement")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:grpc_gateway/class.bzl", GATEWAY = "CLASS")
load("@io_bazel_rules_go//go:def.bzl", "go_library", "go_binary")

grpc_gateway_proto_compile = implement([GO.name, GATEWAY.name])


def grpc_gateway_proto_library(
    name,
    copy_protos_to_genfiles = False,
    deps = [],
    grpc_plugin = None,
    grpc_plugin_options = [],
    imports = [],
    lang = GATEWAY,
    protobuf_plugin_options = [],
    protobuf_plugin = None,
    proto_compile = grpc_gateway_proto_compile,
    proto_deps = [],
    protoc = PROTOC,
    protos = [],
    srcs = [],
    verbose = 0,
    visibility = None,
    go_rule = go_library,

    go_import_map = {},
    logtostderr = True,
    alsologtostderr = False,
    log_dir = None,
    log_level = None,
    import_prefix = None,

    **kwargs):

  args = {}
  args["name"] = name + ".pb"
  args["copy_protos_to_genfiles"] = copy_protos_to_genfiles
  args["imports"] = imports

  args["gen_" + lang.name] = True
  args["gen_grpc_" + lang.name] = True
  args["gen_protobuf_" + lang.name + "_plugin"] = protobuf_plugin
  args["gen_" + lang.name + "_plugin_options"] = protobuf_plugin_options
  args["gen_grpc_" + lang.name + "_plugin"] = grpc_plugin

  args["gen_" + GO.name] = True
  args["gen_grpc_" + GO.name] = True
  args["gen_protobuf_" + GO.name + "_plugin"] = GO.protobuf.executable
  args[GO.name + "_import_map"] = go_import_map + GATEWAY.default_go_import_map

  args["proto_deps"] = [d + ".pb" for d in proto_deps]
  args["protoc"] = protoc
  args["protos"] = protos
  args["verbose"] = verbose
  args["with_grpc"] = True

  args["logtostderr"] = logtostderr
  args["alsologtostderr"] = alsologtostderr
  args["log_dir"] = log_dir
  args["log_level"] = log_level
  args["import_prefix"] = import_prefix

  proto_compile(**args)

  deps += [str(Label(dep)) for dep in lang.grpc.compile_deps]
  deps = list(set(deps + proto_deps))

  go_rule(
     name = name,
     srcs = srcs + [name + ".pb"],
     deps = deps,
     **kwargs
  )


def grpc_gateway_binary(name, srcs = [], deps = [], protos = [], proto_label = "go_default_library", proto_deps = [], **kwargs):
  grpc_gateway_proto_library(
    name = proto_label,
    protos = protos,
    proto_deps = proto_deps,
     **kwargs
  )

  go_binary(
     name = name,
     srcs = srcs,
     deps = deps + [proto_label] + GATEWAY.grpc.compile_deps,
  )
