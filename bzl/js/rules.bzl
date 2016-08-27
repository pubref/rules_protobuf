load("//bzl:base/rules.bzl", "proto_library")
load("//bzl:protoc.bzl", "implement")
load("//bzl:js/class.bzl", JS = "CLASS")

SPEC = [JS]

js_proto_compile = implement(SPEC)

def js_proto_library(name, **kwargs):
  proto_library(name,
                proto_compile = js_proto_compile,
                spec = SPEC,
                **kwargs)
