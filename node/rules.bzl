load("@org_pubref_rules_node//node:rules.bzl", "node_library", "npm_repository")
load("//cpp:rules.bzl", "cpp_proto_repositories")
load("//node:deps.bzl", "DEPS")

load("//protobuf:rules.bzl",
     "proto_compile",
     "proto_language_deps",
     "proto_repositories")

def node_proto_repositories(
    omit_cpp_repositories = False,
    lang_deps = DEPS,
    lang_requires = [
      "npm_protobuf_stack",
      "npm_grpc",
    ],
    **kwargs):

  if not omit_cpp_repositories:
    cpp_proto_repositories()

  rem = proto_repositories(lang_deps = lang_deps,
                           lang_requires = lang_requires,
                           **kwargs)

  # Load remaining (special) deps
  for dep in rem:
    rule = dep.pop("rule")
    if "npm_repository" == rule:
      npm_repository(**dep)
    else:
      fail("Unknown loading rule %s for %s" % (rule, dep))


def node_proto_compile(langs = [str(Label("//node"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

def node_proto_library(
    name,
    langs = [str(Label("//node"))],
    protos = [],
    imports = [],
    inputs = [],
    output_to_workspace = False,
    proto_deps = [
      #"@io_bazel_rules_node//closure/protobuf:jspb",
    ],
    protoc = None,
    pb_plugin = None,
    pb_options = [],
    proto_compile_args = {},
    srcs = [],
    deps = [],
    data = [],
    verbose = 0,
    with_grpc = False,

    requiremap = {},

    **kwargs):

  special_pb_options = []
  if requiremap:
    entries = ["%s=%s" % (k, v) for k, v in requiremap.items()]
    rmap = ",".join(entries)
    special_pb_options += ["require_map='%s'" % rmap]

  proto_compile_args += {
    "name": name + ".pb",
    "protos": protos,
    "deps": [dep + ".pb" for dep in proto_deps],
    "langs": langs,
    "imports": imports,
    "inputs": inputs,
    "pb_options": pb_options + special_pb_options,
    "output_to_workspace": output_to_workspace,
    "with_grpc": with_grpc,
    "verbose": verbose,
  }

  if protoc:
    proto_compile_args["protoc"] = protoc
  if pb_plugin:
    proto_compile_args["pb_plugin"] = pb_plugin

  proto_compile(**proto_compile_args)

  proto_language_deps(
    name = name + "_compile_deps",
    langs = langs,
    file_extensions = [".js"],
  )

  # How to pass along the set of files that the pb file imported?
  # Hmm.  Or should node_library not really exist?

  node_library(
    name = name,
    srcs = srcs + [name + ".pb"],
    data = data + [dep + ".pb" for dep in proto_deps],
    deps = list(set(deps + proto_deps)),
    **kwargs)
