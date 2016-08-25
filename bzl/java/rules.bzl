load("//bzl:base/rules.bzl", "proto_library")
load("//bzl:java/class.bzl", JAVA = "CLASS")
load("//bzl:protoc.bzl", "implement")

SPEC = [JAVA]

java_proto_compile = implement(SPEC)

def java_proto_library(name, **kwargs):
  proto_library(name,
                proto_compile = java_proto_compile,
                spec = SPEC,
                **kwargs)
