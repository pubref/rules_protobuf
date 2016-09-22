load("//protobuf:internal/require.bzl", "require")

def proto_repositories(excludes = [],
                       lang_requires = [],
                       protobuf_requires = [
                           "protobuf",
                           "external_protoc",
                       ],
                       overrides = {},
                       verbose = 0):
  require(
    requires = protobuf_requires + lang_requires,
    excludes = excludes,
    overrides = overrides,
    verbose = verbose,
  )
