load("//bzl:base/rules.bzl", "proto_library")
load("//bzl:protoc.bzl", "implement")
load("//bzl:csharp/class.bzl", CSHARP = "CLASS")

SPEC = [CSHARP]

csharp_proto_compile = implement(SPEC)

def csharp_proto_library(name, **kwargs):
  proto_library(name,
                proto_compile = csharp_proto_compile,
                spec = SPEC,
                **kwargs)
