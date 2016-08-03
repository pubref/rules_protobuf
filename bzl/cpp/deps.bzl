load("//bzl:deps.bzl", "require")


def deps(opts = {}):
  require("grpc", opts)
  require("zlib", opts)
  require("external_zlib", opts)
  require("nanopb", opts)
  require("external_nanopb", opts)
  require("boringssl", opts)
  require("libssl", opts)
  require("protobuf", opts)
  require("external_protobuf_clib", opts)
  require("external_protobuf_compiler", opts)
