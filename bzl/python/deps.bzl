load("//bzl:deps.bzl", "require")

def deps(opts = {}):
  require("grpc", opts)
  require("libssl", opts)
  require("zlib", opts)
