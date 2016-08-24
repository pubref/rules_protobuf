load("//bzl:protoc.bzl", "implement")
load("//bzl:javanano/class.bzl", JAVANANO = "CLASS")
load("//bzl:java/rules.bzl", "java_proto_library")

android_proto_compile = implement(["javanano"])

def android_proto_library(name, **kwargs):
  java_proto_library(name,
                     lang=JAVANANO,
                     proto_compile = android_proto_compile,
                     **kwargs)
