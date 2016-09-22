load("//protobuf:rules.bzl",
     "proto_compile",
     "proto_repositories")

def node_proto_repositories(
    lang_requires = [
    ],
    **kwargs):
  proto_repositories(lang_requires = lang_requires, **kwargs)

def node_proto_compile(langs = [str(Label("//node"))], **kwargs):
  proto_compile(langs = langs, **kwargs)
