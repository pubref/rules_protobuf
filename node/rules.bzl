load("@org_pubref_rules_node//node:rules.bzl", "node_module")
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
      # "npm_protobuf_stack",
      # "npm_grpc",
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
      fail("Unknown loading rule %s for %s" % (rule, dep))
      #npm_repository(**dep)
    else:
      fail("Unknown loading rule %s for %s" % (rule, dep))


def _get_js_variable_name(file):
  return file.basename.rstrip(".js")


def _node_proto_module_impl(ctx):
  """Build a node_module containing all transitive pb files and an index

  The index.js file makes it more palatable to require the files within it.
  It is a mapping such that the proto message "foo.proto" will export it's
  """
  compilation = ctx.attr.compilation.proto_compile_result
  index = ctx.new_file("%s/index.js" % ctx.label.name)
  srcs = []
  exports = {}
  
  for file in compilation.unit.outputs:
    if file.path.endswith("_pb.js") or file.path.endswith("_grpc_pb.js"):
      exports[_get_js_variable_name(file)] = file.short_path
      srcs.append(file)

  content = [
    "module.exports = {",
  ]
  for name, path in exports.items():
    content.append("    '%s': require('./%s')," % (name, path))
  content.append("}")

  ctx.file_action(
    output = index,
    content = "\n".join(content)
  )

  return struct(
    files = depset([index] + srcs),
    node_proto_module = struct(
      index = index,
      srcs = srcs
    )
  )


_node_proto_module = rule(
  implementation = _node_proto_module_impl,
  attrs = {
    "compilation": attr.label(
      providers = ["proto_compile_result"],
      mandatory = True,
    )
  }
)


def _node_proto_module_index_impl(ctx):
  """Export the index file built by the node_proto_module rule"""
  return struct(
    files = depset([ctx.attr.node_proto_module.node_proto_module.index]),
  )

_node_proto_module_index = rule(
  implementation = _node_proto_module_index_impl,
  attrs = {
    "node_proto_module": attr.label(
      providers = ["node_proto_module"],
      mandatory = True,
    )
  }
)


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
    ],
    protoc = None,
    pb_plugin = None,
    pb_options = [],
    proto_compile_args = {},
    deps = [
      "@yarn_modules//:google-protobuf",
    ],
    data = [],
    verbose = 0,
    with_grpc = False,

    **kwargs):

  proto_compile_args += {
    "name": name + ".pb",
    "protos": protos,
    "deps": [dep + ".pb" for dep in proto_deps],
    "langs": langs,
    "imports": imports,
    "inputs": inputs,
    "pb_options": pb_options,
    "output_to_workspace": output_to_workspace,
    "verbose": verbose,
    "with_grpc": with_grpc,
  }

  if protoc:
    proto_compile_args["protoc"] = protoc
  if pb_plugin:
    proto_compile_args["pb_plugin"] = pb_plugin

  # Run protocol compiler
  proto_compile(**proto_compile_args)

  # Gather up the generated outputs 
  _node_proto_module(
    name = name + "_proto_module",
    compilation = name + ".pb",
  )

  # Gather the generated index.js for the above module
  _node_proto_module_index(
    name = name + "_proto_module_index",
    node_proto_module = name + "_proto_module",
  )

  # Package up all generated outputs into a standlone node_module
  node_module(
    name = name,
    index = name + "_proto_module_index",
    layout = "workspace",
    srcs = [name + "_proto_module"],
    deps = depset(deps + proto_deps).to_list(),
    **kwargs)
