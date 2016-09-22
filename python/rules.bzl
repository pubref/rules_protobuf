load("//protobuf:rules.bzl", "proto_compile")

def py_proto_compile(langs = [str(Label("//python"))], **kwargs):
  proto_compile(langs = langs, **kwargs)
