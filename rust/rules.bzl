load("@io_bazel_rules_rust//rust:rust.bzl", "rust_library")
load("//protobuf:rules.bzl", "proto_compile", "proto_language_deps", "proto_repositories")
load("//rust/raze:crates.bzl", "raze_fetch_remote_crates")

def rust_proto_repositories(
    lang_deps = {},
    lang_requires = [],
    **kwargs):
  raze_fetch_remote_crates()

def rust_proto_compile(langs = [str(Label("//rust"))], **kwargs):
  proto_compile(langs = langs, **kwargs)

PB_COMPILE_DEPS = [
    "@org_pubref_rules_protobuf//rust/raze:protobuf",
]

GRPC_COMPILE_DEPS = PB_COMPILE_DEPS + [
    "@org_pubref_rules_protobuf//rust/raze:grpc",
    "@org_pubref_rules_protobuf//rust/raze:tls_api",
    "@org_pubref_rules_protobuf//rust/raze:tls_api_stub",
]

def _basename(f):
  return f.basename[:-len(f.extension) - 1]

def _gen_lib_impl(ctx):
  content = ["extern crate protobuf;"]
  if ctx.attr.grpc:
    content.append("extern crate grpc;")
    content.append("extern crate tls_api;")
  for dep in ctx.attr.deps:
    content.append("extern crate %s;" % dep.label.name)
    content.append("use %s::*;" % dep.label.name)
  for f in ctx.files.files:
    content.append("pub mod %s;" % _basename(f))
    content.append("pub use %s::*;" % _basename(f))
    if ctx.attr.grpc:
      content.append("pub mod %s_grpc;" % _basename(f))
      content.append("pub use %s_grpc::*;" % _basename(f))
  ctx.actions.write(
    ctx.outputs.out,
    "\n".join(content),
    False,
  )

_gen_lib = rule(
  implementation = _gen_lib_impl,
  attrs = {
    "files": attr.label_list(allow_files = True),
    "deps": attr.label_list(),
    "grpc": attr.bool(default = True),
  },
  outputs = {"out": "%{name}.rs"},
  output_to_genfiles = True,  # For compatibility with proto_compile.
)

def rust_proto_library(
    name,
    langs = [str(Label("//rust"))],
    protos = [],
    imports = [],
    inputs = [],
    proto_deps = [],
    output_to_workspace = False,
    protoc = None,
    pb_plugin = None,
    pb_options = [],
    grpc_plugin = None,
    grpc_options = [],
    proto_compile_args = {},
    with_grpc = False,
    srcs = [],
    deps = [],
    verbose = 0,
    **kwargs):
  proto_compile_args += {
    "name": name + "_pb",
    "protos": protos,
    "deps": [dep + "_pb" for dep in proto_deps],
    "langs": langs,
    "imports": imports,
    "inputs": inputs,
    "pb_options": pb_options,
    "grpc_options": grpc_options,
    "output_to_workspace": output_to_workspace,
    "verbose": verbose,
    "with_grpc": with_grpc,
  }

  if protoc:
    proto_compile_args["protoc"] = protoc
  if pb_plugin:
    proto_compile_args["pb_plugin"] = pb_plugin
  if grpc_plugin:
    proto_compile_args["grpc_plugin"] = grpc_plugin

  proto_compile(**proto_compile_args)

  _gen_lib(
    name = name + "_pb/lib",
    files = protos,
    deps = proto_deps,
    grpc = with_grpc
  )

  if with_grpc:
    compile_deps = GRPC_COMPILE_DEPS
  else:
    compile_deps = PB_COMPILE_DEPS

  rust_library(
    name = name,
    srcs = srcs + [name + "_pb", name + "_pb/lib"],
    deps = depset(deps + compile_deps + proto_deps).to_list(),
    **kwargs
  )
