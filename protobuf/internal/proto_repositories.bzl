load("//protobuf:internal/require.bzl", "require")
load("//protobuf:deps.bzl", "DEPS")

def proto_repositories(excludes = [],
                       lang_deps = {},
                       lang_requires = [],
                       protobuf_deps = DEPS,
                       protobuf_requires = [
                         "com_google_protobuf",
                         "protobuf",
                         "protobuf_clib",
                         "protocol_compiler",
                         "protobuf_headers",
                       ],
                       overrides = {},
                       strict = False,
                       verbose = 0):
  return require(
    keys = protobuf_requires + lang_requires,
    deps = protobuf_deps + lang_deps,
    excludes = excludes,
    overrides = overrides,
    verbose = verbose,
    strict = strict,
  )
