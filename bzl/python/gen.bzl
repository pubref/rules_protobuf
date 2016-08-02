def pre(ctx, gen_dir, args, requires, provides):
  """Configure arguments for py generation
  """
  py_dir = ctx.var["GENDIR"] + "/" + gen_dir

  # Add basic support
  #
  py_out = py_dir
  py_opts = [] + ctx.attr.gen_py_options
  if py_opts:
    py_out = ",".join(py_opts) + ":" + py_out
  args += ["--python_out=" + py_out]

  # Add grpc support if requested.
  #
  # if (ctx.attr.with_grpc):
  #   protoc_gen_python_grpc = ctx.executable.protoc_gen_python_grpc
  #   args += ["--plugin=protoc-gen-python-grpc=" + protoc_gen_python_grpc.path]
  #   args += ["--python-grpc_out=" + py_out]
  #   requires += [protoc_gen_python_grpc]

  # Create list of output files that we expect to be generated.
  #

  for srcfile in ctx.files.srcs:

    basename = srcfile.basename
    filename = basename[:-len('.proto')] + "_pb2.py"
    protofile = ctx.new_file(basename)
    pyfile = ctx.new_file(filename)

    # Copy the proto source to the context namespace (where the BUILD
    # rule is called)
    ctx.action(
      mnemonic = "RebaseSrc",
      inputs = [srcfile],
      outputs = [protofile],
      arguments = [srcfile.path, protofile.path],
      command = "cp $1 $2")

    requires += [protofile]
    provides += [pyfile]

  return (args, requires, provides)

def post(ctx, requires, provides):
  """Post processing for py
  """
  return (requires, provides)
