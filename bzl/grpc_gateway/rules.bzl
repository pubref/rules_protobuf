load("//bzl:protoc.bzl", "EXECUTABLE", "implement")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:grpc_gateway/class.bzl", GATEWAY = "CLASS")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

gateway_proto_compile = implement([GATEWAY.name, GO.name])

def gateway_proto_library(
    name,
    copy_protos_to_genfiles = False,
    deps = [],
    grpc_plugin = None,
    grpc_plugin_options = [],
    imports = [],
    lang = GATEWAY,
    protobuf_plugin_options = [],
    protobuf_plugin = None,
    proto_compile = gateway_proto_compile,
    protoc = EXECUTABLE,
    srcs = [],
    verbose = 0,
    visibility = None,
    go_deps = [],
    go_srcs = [],

    logtostderr = True,
    alsologtostderr = False,
    log_dir = None,
    log_level = None,
    import_prefix = None,
    go_import_map = {},

    **kwargs):

  args = {}
  args["name"] = name + ".pb"
  args["copy_protos_to_genfiles"] = copy_protos_to_genfiles
  args["deps"] = [d + ".pb" for d in deps]
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

  args["protoc"] = protoc
  args["protos"] = srcs
  args["verbose"] = verbose
  args["with_grpc"] = True

  args["logtostderr"] = logtostderr
  args["alsologtostderr"] = alsologtostderr
  args["log_dir"] = log_dir
  args["log_level"] = log_level
  args["import_prefix"] = import_prefix

  proto_compile(**args)

  deps += [str(Label(dep)) for dep in lang.grpc.compile_deps]
  deps = list(set(deps + go_deps))

  go_library(
     name = name,
     srcs = go_srcs + [name + ".pb"],
     deps = deps,
     **kwargs
  )
