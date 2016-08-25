load("//bzl:base/rules.bzl", "proto_library")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:protoc.bzl", "implement")

SPEC = [GO]

go_proto_compile = implement(SPEC)

def go_proto_library(name, go_import_map = {}, proto_compile_args = {}, **kwargs):
  proto_library(name,
                proto_compile = go_proto_compile,
                proto_compile_args = {
                  "go_import_map": go_import_map,
                } + proto_compile_args,
                spec = SPEC,
                **kwargs)
