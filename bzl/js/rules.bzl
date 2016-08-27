load("//bzl:protoc.bzl", "implement")
load("//bzl:js/class.bzl", JS = "CLASS")

js_proto_compile = implement([JS])
