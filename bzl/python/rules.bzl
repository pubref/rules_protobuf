load("//bzl:base/rules.bzl", "proto_library")
load("//bzl:protoc.bzl", "implement")
load("//bzl:python/class.bzl", PYTHON = "CLASS")

SPEC = [PYTHON]

py_proto_compile = implement(SPEC)

def py_proto_library(name, **kwargs):
  proto_library(name,
                proto_compile = py_proto_compile,
                spec = SPEC,
                **kwargs)
