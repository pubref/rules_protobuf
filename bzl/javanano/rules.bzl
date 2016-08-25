load("//bzl:java/rules.bzl", "java_proto_library")
load("//bzl:javanano/class.bzl", JAVANANO = "CLASS")
load("//bzl:protoc.bzl", "implement")

SPEC = [JAVANANO]

android_proto_compile = implement(SPEC)

def android_proto_library(name, **kwargs):
  java_proto_library(name,
                     proto_compile = android_proto_compile,
                     spec = SPEC,
                     **kwargs)
