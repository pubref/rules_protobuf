load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")
load("//cpp:rules.bzl", "cpp_proto_repositories")
load("//ruby:deps.bzl", "DEPS")

def ruby_proto_repositories(
    omit_cpp_repositories = False,
    lang_deps = DEPS,
    lang_requires = [
      "protoc_gen_grpc_ruby",
    ], **kwargs):

  if not omit_cpp_repositories:
    cpp_proto_repositories()

  proto_repositories(lang_deps = lang_deps,
                     lang_requires = lang_requires,
                     **kwargs)

def ruby_proto_compile(langs = [str(Label("//ruby"))], **kwargs):
  proto_compile(langs = langs, **kwargs)
