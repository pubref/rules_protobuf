def pre(lang, ctx, gendir, args, srcs, requires, provides):

  if (lang.plugin_outdir_hook):
    outdir = lang.plugin_out_hook(lang, ctx, gendir)
  else:
    outdir = gendir

  # Default language options
  plugin_args = lang.plugin_args

  # Options specified in context
  plugin_args += getattr(ctx.attr, "gen_" + lang + "_args")

  # if opts:
  #   plugin_args = ",".join(opts) + ":" + plugin_args

  # Configure plugin definition if defined
  if lang.plugin_binary:
    plugin_exe_name = "gen_" + lang.name + "_plugin"
    plugin_exe = getattr(ctx.attr, plugin_exe_name)
    if not plugin_exe:
      fail("Undefined plugin executable", plugin_exe_name)
    args += ["--plugin=%s=%s" % (lang.plugin_name, lang.plugin_exe.path)]

  # Configure plugin for this language
  args += ["--%s_out=%s:%s" % (lang.name, lang.plugin_name, plugin_args, outdir.path)]

  for srcfile in ctx.files.srcs:
    basename = srcfile.basename
    filename = basename[:-len('.proto')] + lang.file_extension
    pbfile = ctx.new_file(filename)
    srcs += [srcfile.path]
    requires += [srcfile]
    provides += [pbfile]

  return (args, srcs, requires, provides)


def post(ctx, requires, provides):
  return (requires, provides)

py_proto_compile = _compile([ LANGUAGE.get("python") ])

#def py_proto_compile(**kwargs):
#  pass
  #rule = _compile([ LANGUAGE.get("python") ])
  #_rule(gen_py = True)
