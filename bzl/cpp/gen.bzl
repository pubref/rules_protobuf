def pre(ctx, gen_dir, args, srcs, requires, provides):
  """Configure arguments for cpp generation
  """
  cpp_dir = ctx.var["GENDIR"] + "/" + gen_dir + ctx.label.package

  # **************** Args ****************

  cpp_out = cpp_dir
  cpp_opts = [] + ctx.attr.gen_cpp_options

  if cpp_opts:
    cpp_out = ",".join(cpp_opts) + ":" + cpp_out

  args += ["--cpp_out=" + cpp_out]

  if ctx.attr.with_grpc:
    protoc_gen_grpc = ctx.executable.protoc_gen_grpc
    requires += [protoc_gen_grpc]
    args += [
      "--plugin=protoc-gen-grpc=" + protoc_gen_grpc.path,
      "--grpc_out=" + cpp_out,
    ]

    for src in ctx.files.srcs:
      args += ["--proto_path=" + src.dirname]
      requires += [src]

  # **************** Provides ****************

  for srcfile in ctx.files.srcs:
    basename = srcfile.basename[:-len('.proto')]
    protofile = ctx.new_file(basename)

    pb_hfile = ctx.new_file(basename + ".pb.h")
    pb_ccfile = ctx.new_file(basename + ".pb.cc")
    provides += [pb_hfile, pb_ccfile]

    if (ctx.attr.with_grpc):
      grpc_hfile = ctx.new_file(basename + ".grpc.pb.h")
      grpc_ccfile = ctx.new_file(basename + ".grpc.pb.cc")
      provides += [grpc_hfile, grpc_ccfile]

    # Copy the proto source to the context namespace (where the BUILD
    # rule is called) to better support imports (necessary).
    ctx.action(
      mnemonic = "RebaseSrc",
      inputs = [srcfile],
      outputs = [protofile],
      arguments = [srcfile.path, protofile.path],
      command = "cp $1 $2")

    args += ["--proto_path=" + pb_hfile.dirname]
    srcs += [protofile.path]
    requires += [protofile]


  return (args, srcs, requires, provides)


def post(ctx, requires, provides):
  """Post processing for cpp
  """
  return (requires, provides)
