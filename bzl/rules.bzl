load("//bzl:protoc/deps.bzl", rules_protobuf_protoc = "deps")
load("//bzl:cpp/deps.bzl", rules_protobuf_cpp = "deps")
load("//bzl:go/deps.bzl", rules_protobuf_go = "deps")
load("//bzl:java/deps.bzl", rules_protobuf_java = "deps")
load("//bzl:python/deps.bzl", rules_protobuf_python = "deps")

load("//bzl:protoc/rules.bzl", protoc = "gen")
load("//bzl:cpp/rules.bzl", protoc_cpp = "gen")
load("//bzl:go/rules.bzl", protoc_go = "gen")
load("//bzl:java/rules.bzl", protoc_java = "gen")
load("//bzl:python/rules.bzl", protoc_py = "gen")


def rules_protobuf(
  with_protoc=True,
  with_cpp=False,
  with_go=False,
  with_java=False,
  with_js=False,
  with_python=False):

  if with_protoc:
    rules_protobuf_protoc()

  if with_cpp:
    rules_protobuf_cpp()
  if with_go:
    rules_protobuf_go()
  if with_java:
    rules_protobuf_java()
  if with_python:
    rules_protobuf_python()
