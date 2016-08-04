def pre(ctx, gen_dir, args, srcs, requires, provides):
  """Configure arguments for go generation
  """
  go_dir = ctx.var["GENDIR"] + "/" + gen_dir + ctx.label.package

  # **************** Args ****************

  protoc_gen_go = ctx.executable.protoc_gen_go
  args += ["--plugin=protoc-gen-go=" + protoc_gen_go.path]

  go_out = go_dir
  go_opts = [] + ctx.attr.gen_go_options
  import_map = {} + ctx.attr.import_map
  if (ctx.attr.verbose > 1):
    print("import_map: %s" % import_map)

  for (srcfilename, import_prefix) in import_map.items():
    go_opts += ["M" + srcfilename + "=" + import_prefix]

  if (ctx.attr.with_grpc):
    go_opts += ["plugins=grpc"]

  if go_opts:
    go_out = ",".join(go_opts) + ":" + go_out

  args += ["--go_out=" + go_out]

  #args += ["--descriptor_set_out=" + ctx.outputs.descriptor.path]

  # **************** Requires ****************

  requires += [protoc_gen_go]

  # **************** Provides ****************

  for srcfile in ctx.files.srcs:
    basename = srcfile.basename
    filename = basename[:-len('.proto')] + ".pb.go"
    #protofile = ctx.new_file(basename)
    gofile = ctx.new_file(filename)

    # Copy the proto source to the context namespace (where the BUILD
    # rule is called) to better support imports (necessary?).
    # ctx.action(
    #   mnemonic = "RebaseSrc",
    #   inputs = [srcfile],
    #   outputs = [protofile],
    #   arguments = [srcfile.path, protofile.path],
    #   command = "cp $1 $2")

    #args += ["--proto_path=" + protofile.dirname]
    args += ["--proto_path=" + srcfile.dirname]
    #srcs += [protofile.path]
    srcs += [srcfile.path]
    requires += [srcfile]
    provides += [gofile]

  return (args, srcs, requires, provides)

def post(ctx, requires, provides):
  """Post processing for go
  """
  # Experimental hack to try to get generated files back into the
  # source tree.  Probably futile (not to mention dangerous) given
  # bazel sandbox model.

  # for srcfile in ctx.files.srcs:
  #   basename = srcfile.basename
  #   dirname = srcfile.dirname
  #   filename = basename[:-len('.proto')] + ".pb.go"
  #   pbgo_path = dirname + "/" + filename

  #   # Copy the generated protobuf file into the source tree!
  #   ctx.action(
  #     mnemonic = "CopyPbGoToSrcTree",
  #     inputs = [srcfile],
  #     outputs = [srcfile], #hack to fool bazel
  #     arguments = [pbgo_path],
  #     command = "cp $1 /Users/pcj/tmp")

    #if (ctx.attr.verbose):
    #print("Copied %s into source tree" % pbgo_path)

  return (requires, provides)
