load("//bzl:protoc.bzl", "EXECUTABLE", "implement", "protoc_genrule")
load("//bzl:util.bzl", "invoke")
load("//bzl:cpp/class.bzl", CPP = "CLASS")

cc_proto_compile = implement(["cpp"])

def cc_proto_library(
    name,
    protos = [],
    lang = CPP,
    srcs = [],
    imports = [],
    visibility = None,
    testonly = 0,
    protoc = EXECUTABLE,
    protobuf_plugin_options = [],
    protobuf_plugin = None,
    grpc_plugin = None,
    grpc_plugin_options = [],
    descriptor_set = None,
    verbose = False,
    with_grpc = False,
    deps = [],
    hdrs = [],
    linkopts = ['-ldl'],
    **kwargs):

  result = protoc_genrule(
    spec = [lang],
    name = name + "_pb",
    protos = protos,
    protoc = protoc,
    protobuf_plugin = protobuf_plugin,
    visibility = visibility,
    testonly = testonly,
    imports = imports,
    with_grpc = with_grpc,
    verbose = verbose,
  )

  if with_grpc:
    cc_deps = [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]
  else:
    cc_deps = [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]

  native.cc_library(
    name = name,
    srcs = srcs + result.outs,
    deps = deps + cc_deps,
    linkopts = linkopts,
    **kwargs
  )
