load("//protobuf:rules.bzl", "proto_compile")

def ruby_proto_compile(langs = [str(Label("//ruby"))], **kwargs):
  proto_compile(langs = langs, **kwargs)
