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
  name = file.basename.rstrip(".js")
  # Deal with special characters here?
  return name


def _node_proto_module_impl(ctx):
  compilation = ctx.attr.compilation.proto_compile_result
  index_js = ctx.new_file("%s/index.js" % ctx.label.name)

  exports = {}

  for unit in compilation.transitive_units:
    for file in unit.outputs:
      if file.path.endswith("_pb.js"):
        name = _get_js_variable_name(file)
        exports[name] = file.short_path
      elif file.path.endswith("_grpc_pb.js"):
        name = _get_js_variable_name(file)
        exports[name] = file.short_path

  content = []
  content.append("module.exports = {")
  for name, path in exports.items():
    content.append("    '%s': require('./%s')," % (name, path))
  content.append("}")

  ctx.file_action(
    output = index_js,
    content = "\n".join(content)
  )

  return struct(
    files = depset([index_js]),
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
    srcs = [],
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

  proto_compile(**proto_compile_args)

  _node_proto_module(
    name = name + "_index",
    compilation = name + ".pb",
  )

  node_module(
    name = name,
    index = name + "_index",
    layout = "workspace",
    srcs = srcs + [name + ".pb"],
    data = data + [dep + ".pb" for dep in proto_deps],
    deps = depset(deps + proto_deps).to_list(),
    **kwargs)
