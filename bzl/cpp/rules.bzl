load("//bzl:protoc.bzl", "protoc", PROTOC = "EXECUTABLE")
load("//bzl:invoke.bzl", "invoke")
load("//bzl:compile.bzl", "implement_compile")
load("//bzl:cpp/descriptor.bzl", CPP = "DESCRIPTOR")
#load("@com_github_google_protobuf//:protobuf.bzl", CPP = "_cc_proto_library")

proto_compile = implement_compile(["cpp"])

def cc_proto_library(
    name,
    protos,
    lang = CPP,
    srcs = [],
    imports = [],
    visibility = None,
    testonly = 0,
    protoc_executable = PROTOC,
    protobuf_plugin_options = [],
    protobuf_plugin_executable = None,
    grpc_plugin_executable = None,
    grpc_plugin_options = [],
    descriptor_set = None,
    verbose = True,
    with_grpc = False,
    deps = [],
    hdrs = [],
    **kwargs):

  self = {
    "protos": protos,
    "with_grpc": with_grpc,
    "outs": [],
  }

  invoke("build_generated_files", lang, self)

  print("self %s" % self)

  proto_compile(
    name = name + "_pb",
    protos = protos,
    outs = self["outs"],
    gen_cpp = True,
    gen_grpc_cpp = with_grpc,
    protoc = protoc_executable,
  )

  # result = protoc(
  #   lang = lang,
  #   name = name + "_pb",
  #   protos = protos,
  #   protoc_executable = protoc_executable,
  #   protobuf_plugin_executable = protobuf_plugin_executable,
  #   visibility = visibility,
  #   testonly = testonly,
  #   imports = imports,
  #   with_grpc = with_grpc,
  #   execute = False,
  # )

  cc_deps = [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]
  if with_grpc:
    cc_deps += [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]

  #print("hdrs: $location(%s)" % result.hdrs)

  native.cc_library(
    name = name,
    srcs = srcs + self["outs"],
    deps = deps + cc_deps,
    #hdrs = result.hdrs + hdrs,
    **kwargs
  )


# def cc_proto_library_genrule(
#     name,
#     protos,
#     lang = CPP,
#     srcs = [],
#     imports = [],
#     visibility = None,
#     testonly = 0,
#     protoc_executable = None,
#     protobuf_plugin_executable = None,
#     with_grpc = False,
#     deps = [],
#     hdrs = [],
#     **kwargs):

#   result = protoc(
#     lang = lang,
#     name = name + "_pb",
#     protos = protos,
#     protoc_executable = protoc_executable,
#     protobuf_plugin_executable = protobuf_plugin_executable,
#     visibility = visibility,
#     testonly = testonly,
#     imports = imports,
#     verbose = True,
#     with_grpc = with_grpc,
#   )

#   cc_deps = [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]
#   if with_grpc:
#     cc_deps += [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]

#   print("hdrs: $location(%s)" % result.hdrs)

#   native.cc_library(
#     name = name,
#     srcs = srcs + result.outs,
#     deps = deps + cc_deps,
#     #hdrs = result.hdrs + hdrs,
#     **kwargs
#   )
