load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")

def ruby_proto_repositories(
    lang_requires = [
      "grpc",
      "external_protobuf_compiler",
      "external_protoc_gen_grpc_ruby",
    ], **kwargs):
  proto_repositories(lang_requires = lang_requires, **kwargs)

def ruby_proto_compile(langs = [str(Label("//ruby"))], **kwargs):
  proto_compile(langs = langs, **kwargs)
