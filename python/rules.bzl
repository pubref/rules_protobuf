load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")
load("//python:deps.bzl", "DEPS")
load("//cpp:rules.bzl", "cpp_proto_repositories")

def py_proto_repositories(
    omit_cpp_repositories = False,
    lang_deps = DEPS,
    lang_requires = [
      "protoc_gen_grpc_python",
    ], **kwargs):

  if not omit_cpp_repositories:
    cpp_proto_repositories()

  proto_repositories(lang_deps = lang_deps,
                     lang_requires = lang_requires,
                     **kwargs)

def py_proto_compile(langs = [str(Label("//python"))], **kwargs):
  proto_compile(langs = langs, **kwargs)
