load("//bzl:base/rules.bzl", "proto_library")
load("//bzl:protoc.bzl", "implement")
load("//bzl:ruby/class.bzl", RUBY = "CLASS")

SPEC = [RUBY]

ruby_proto_compile = implement(SPEC)

def ruby_proto_library(name, **kwargs):
  proto_library(name,
                proto_compile = ruby_proto_compile,
                spec = SPEC,
                **kwargs)
