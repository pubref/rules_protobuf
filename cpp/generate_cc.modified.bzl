"""Generates C++ grpc stubs from proto_library rules.

This is an internal rule used by cc_grpc_library, and shouldn't be used
directly.

This file becomes symlinked to replace the original
@com_google_grpc//bazel/generate_cc.bzl, which does not seem to work
out of the box.  IF YOU UPDATE TO A NEWER VERSION OF GRPC/GRPC, THERE
MAY BE CHANGES TO THAT FILE WHICH MIGHT EITHER BREAK THIS OR MAKE IT
OBSOLETE.

Modifications made for rules_protobuf: out of the box,
generate_cc_impl does not seem to work if run within the context of an
external workspace.

The first change is that we need to adjust the output paths to account
for the external workspace_root.  Previously, outs is computed by
slicing off the value of ctx.label.package prefix from proto.path.  We
ALSO need to slice off the workspace_root, if it exists.  Therefore,
we've created a new int field 'prefix_len' that is the sum of these
two lengths.

The second change is that we need protoc to evaluate within the
context of the workspace_root rather than the execroot.  To do this,
we shift into the external workspace with a 'cd
external/com_google_grpc', and adjust dir_out, plugin_out,
cpp_out etc to be relative to the forward shifted position.

"""

def generate_cc_impl(ctx):
  """Implementation of the generate_cc rule."""
  protos = [f for src in ctx.attr.srcs for f in src.proto.direct_sources]
  includes = [f for src in ctx.attr.srcs for f in src.proto.transitive_imports]
  outs = []
  label_len = len(ctx.label.package) + 1
  workspace_len = len(ctx.label.workspace_root) + 1
  prefix_len = label_len + workspace_len

  if ctx.executable.plugin:
    outs += [proto.path[prefix_len:-len(".proto")] + ".grpc.pb.h" for proto in protos]
    outs += [proto.path[prefix_len:-len(".proto")] + ".grpc.pb.cc" for proto in protos]
    if ctx.attr.generate_mock:
      outs += [proto.path[prefix_len:-len(".proto")] + "_mock.grpc.pb.h" for proto in protos]
  else:
    outs += [proto.path[prefix_len:-len(".proto")] + ".pb.h" for proto in protos]
    outs += [proto.path[prefix_len:-len(".proto")] + ".pb.cc" for proto in protos]

  out_files = [ctx.new_file(out) for out in outs]
  dir_out = "../../%s/%s" % (str(ctx.genfiles_dir.path), ctx.label.workspace_root)

  arguments = []
  if ctx.executable.plugin:
    arguments += ["--plugin=protoc-gen-PLUGIN=../../" + ctx.executable.plugin.path]
    flags = list(ctx.attr.flags)
    if ctx.attr.generate_mock:
      flags.append("generate_mock_code=true")
    arguments += ["--PLUGIN_out=" + ",".join(flags) + ":" + dir_out]
    additional_input = [ctx.executable.plugin]
  else:
    arguments += ["--cpp_out=" + ",".join(ctx.attr.flags) + ":" + dir_out]
    additional_input = []

  #arguments += ["-I{0}={0}".format(include.path) for include in includes]
  arguments += [proto.path[workspace_len:] for proto in protos]

  # create a list of well known proto files if the argument is non-None
  well_known_proto_files = []
  if ctx.attr.well_known_protos:
    f = ctx.attr.well_known_protos.files.to_list()[0].dirname
    if f != "external/com_google_protobuf/src/google/protobuf":
      print("Error: Only @com_google_protobuf//:well_known_protos is supported")
    else:
      # f points to "external/com_google_protobuf/src/google/protobuf"
      # add -I argument to protoc so it knows where to look for the proto files.
      arguments += ["-I{0}".format(f + "/../..")]
      well_known_proto_files = [f for f in ctx.attr.well_known_protos.files]

  proto_cmd = "../../%s " % ctx.executable._protoc.path
  proto_cmd += " ".join(arguments)

  cmds = [
    "cd %s" % ctx.label.workspace_root,
    proto_cmd
  ]

  ### print("CMDS> %r" % cmds)

  ctx.action(
      inputs = protos + includes + additional_input + well_known_proto_files + [ctx.executable._protoc],
      outputs = out_files,
      command = " && ".join(cmds),
  )

  return struct(files=depset(out_files))

_generate_cc = rule(
    attrs = {
        "srcs": attr.label_list(
            mandatory = True,
            non_empty = True,
            providers = ["proto"],
        ),
        "plugin": attr.label(
            executable = True,
            providers = ["files_to_run"],
            cfg = "host",
        ),
        "flags": attr.string_list(
            mandatory = False,
            allow_empty = True,
        ),
        "well_known_protos" : attr.label(
            mandatory = False,
        ),
        "generate_mock" : attr.bool(
            default = False,
            mandatory = False,
        ),
        "_protoc": attr.label(
            default = Label("//external:protocol_compiler"),
            executable = True,
            cfg = "host",
        ),
    },
    # We generate .h files, so we need to output to genfiles.
    output_to_genfiles = True,
    implementation = generate_cc_impl,
)

def generate_cc(well_known_protos, **kwargs):
  if well_known_protos:
    _generate_cc(well_known_protos="@com_google_protobuf//:well_known_protos", **kwargs)
  else:
    _generate_cc(**kwargs)
