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

  # **************** Provides ****************

  for srcfile in ctx.files.srcs:
    basename = srcfile.basename[:-len('.proto')]
    protofile = ctx.new_file(basename)
    pbhfile = ctx.new_file(basename + ".pb.h")
    pbccfile = ctx.new_file(basename + ".pb.cc")

    # Copy the proto source to the context namespace (where the BUILD
    # rule is called) to better support imports (necessary).
    ctx.action(
      mnemonic = "RebaseSrc",
      inputs = [srcfile],
      outputs = [protofile],
      arguments = [srcfile.path, protofile.path],
      command = "cp $1 $2")

    args += ["--proto_path=" + pbhfile.dirname]
    srcs += [protofile.path]
    requires += [protofile]
    provides += [pbhfile, pbccfile]

  return (args, srcs, requires, provides)


def post(ctx, requires, provides):
  """Post processing for cpp
  """
  return (requires, provides)
