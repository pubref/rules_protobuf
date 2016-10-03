load("//protobuf:rules.bzl", "proto_compile", "proto_repositories")

def py_proto_repositories(
    lang_requires = [
      "grpc",
      "external_protobuf_compiler",
      "external_protoc_gen_grpc_python",
    ], **kwargs):
  proto_repositories(lang_requires = lang_requires, **kwargs)

def py_proto_compile(langs = [str(Label("//python"))], **kwargs):
  proto_compile(langs = langs, **kwargs)
