load("//bzl:deps.bzl", "require")

def deps(opts = {}):
  require("protoc_linux_x86_64", opts)
  require("protoc_macosx", opts)
