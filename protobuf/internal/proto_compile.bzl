def _capitalize(s):
  return s[0:1].upper() + s[1:]


def _pascal_case(s):
  return "".join([_capitalize(part) for part in s.split("_")])


def _emit_params_file_action(ctx, path, mnemonic, cmds):
  """Helper function that writes a potentially long command list to a file.
  Args:
    ctx (struct): The ctx object.
    path (string): the file path where the params file should be written.
    mnemonic (string): the action mnemomic.
    cmds (list<string>): the command list.
  Returns:
    (File): an executable file that runs the command set.
  """
  filename = "%s.%sFile.params" % (path, mnemonic)
  f = ctx.new_file(ctx.configuration.bin_dir, filename)
  ctx.file_action(output = f,
                  content = "\n".join(["set -e"] + cmds),
                  executable = True)
  return f


def _get_offset_path(root, path):
  """Adjust path relative to offset"""

  if path.startswith("/"):
    fail("path argument must not be absolute: %s" % path)

  if not root:
    return path

  if root == ".":
    return path

  # "external/foobar/file.proto" --> "file.proto"
  if path.startswith(root):
    start = len(root)
    if not root.endswith('/'):
      start += 1
      return path[start:]

  depth = root.count('/') + 1
  return "../" * depth + path


def _get_import_mappings_for(files, prefix, label):
  """For a set of files that belong the the given context label, create a mapping to the given prefix."""
  # Go-specific code crept in here.
  # if run.lang.prefix and run.lang.prefix.go_prefix:
  #     options += get_go_importmap_options(run, builder)

  mappings = {}
  for file in files:
    src = file.short_path
    # File in an external repo looks like:
    # '../WORKSPACE/SHORT_PATH'.  We want just the SHORT_PATH.
    if src.startswith("../"):
      parts = src.split("/")
      src = "/".join(parts[2:])
    dst = [prefix, label.package]
    name_parts = label.name.split(".")
    # special case to elide last part if the name is
    # 'go_default_library.pb'
    if name_parts[0] != "go_default_library":
      dst.append(name_parts[0])
    mappings[src] = "/".join(dst)

  return mappings


def _get_go_importmap_options(run, builder):
  """Override behavior to add plugin options before building the --go_out option"""

  lang = run.lang
  go_prefix = lang.prefix.go_prefix
  mappings = lang.import_map
  mappings += _get_import_mappings_for(run.data.protos,go_prefix, run.data.label)

  # Then add in the transitive set from dependent rules.
  for unit in run.data.transitive_units:
    # Map to this go_prefix if within same workspace, otherwise
    # use theirs.
    prefix = go_prefix
    if unit.workspace_name != run.data.workspace_name:
      prefix = unit.prefix
    #print("protos %s, prefix %s, label: %s" % (unit.data.protos, prefix, unit.data.label))
    mappings += _get_import_mappings_for(unit.data.protos, prefix, unit.data.label)

  if run.data.verbose > 1:
    print("go_import_map: %s" % mappings)

  opts = ["M%s=%s" % (k, v) for k, v in mappings.items()]
  return opts


def _build_output_jar(run, builder):
  """Build a jar file for protoc to dump java classes into."""
  ctx = run.ctx
  execdir = run.data.execdir
  name = run.lang.name
  protojar = ctx.new_file("%s_%s.jar" % (run.data.label.name, name))
  builder["outputs"] += [protojar]
  builder[name + "_jar"] = protojar
  builder[name + "_outdir"] = _get_offset_path(execdir, protojar.path)


def _build_output_library(run, builder):
  """Build a library.js file for protoc to dump java classes into."""
  ctx = run.ctx
  execdir = run.data.execdir
  name = run.lang.name
  jslib = ctx.new_file(run.data.label.name + run.lang.pb_file_extensions[0])
  builder["jslib"] = [jslib]
  builder["outputs"] += [jslib]

  parts = jslib.short_path.rpartition("/")
  filename = "/".join([parts[0], run.data.label.name])
  library_path = _get_offset_path(run.data.execdir, filename)
  builder[name + "_pb_options"] += ["library=" + library_path]


def _build_output_srcjar(run, builder):
  ctx = run.ctx
  name = run.lang.name
  protojar = builder[name + "_jar"]
  srcjar_name = "%s_%s.srcjar" % (run.data.label.name, name)
  srcjar = ctx.new_file("%s_%s.srcjar" % (run.data.label.name, name))
  run.ctx.action(
    mnemonic = "CpJarToSrcJar",
    inputs = [protojar],
    outputs = [srcjar],
    arguments = [protojar.path, srcjar.path],
    command = "cp $1 $2",
  )

  # Remove protojar from the list of provided outputs
  builder["outputs"] = [e for e in builder["outputs"] if e != protojar]
  builder["outputs"] += [srcjar]

  if run.data.verbose > 2:
    print("Copied jar %s srcjar to %s" % (protojar.path, srcjar.path))


def _build_output_files(run, builder):
  """Build a list of files we expect to be generated."""

  ctx = run.ctx
  protos = run.data.protos
  if not protos:
    fail("Empty proto input list.", "protos")

  exts = run.exts

  for file in protos:
    base = file.basename[:-len(".proto")]
    if run.lang.output_file_style == 'pascal':
      base = _pascal_case(base)
    if run.lang.output_file_style == 'capitalize':
      base = _capitalize(base)
    for ext in exts:
      pbfile = ctx.new_file(base + ext)
      builder["outputs"] += [pbfile]


def _build_output_libdir(run, builder):
  # This is currently csharp-specific, which needs to have the
  # output_dir positively adjusted to the package directory.
  ctx = run.ctx
  execdir = run.data.execdir
  name = run.lang.name

  builder[name + "_outdir"] = _get_offset_path(execdir, run.data.descriptor_set.dirname)
  _build_output_files(run, builder)


def _build_descriptor_set(data, builder):
  """Build a list of files we expect to be generated."""
  builder["args"] += ["--descriptor_set_out=" + data.descriptor_set.path]


def _build_plugin_invocation(name, plugin, execdir, builder):
  """Add a '--plugin=NAME=PATH' argument if the language descriptor
  requires one.
  """
  tool = _get_offset_path(execdir, plugin.path)
  builder["inputs"] += [plugin]
  builder["args"] += ["--plugin=protoc-gen-%s=%s" % (name, tool)]


def _build_protobuf_invocation(run, builder):
  """Build a --plugin option if required for basic protobuf generation.
  Args:
    run (struct): the compilation run object.
    builder (dict): the compilation builder data.
  Built-in language don't need this.
  """
  lang = run.lang
  if not lang.pb_plugin:
    return
  name = lang.pb_plugin_name or lang.name
  _build_plugin_invocation(name,
                           lang.pb_plugin,
                           run.data.execdir,
                           builder)


def _build_grpc_invocation(run, builder):
  """Build a --plugin option if required for grpc service generation
  Args:
    run (struct): the compilation run object.
    builder (dict): the compilation builder data.
  Built-in language don't need this.
  """
  lang = run.lang
  if not lang.grpc_plugin:
    return
  name = lang.grpc_plugin_name or "grpc-" + lang.name
  _build_plugin_invocation(name,
                           lang.grpc_plugin,
                           run.data.execdir,
                           builder)


def _get_mappings(files, label, prefix):
  """For a set of files that belong the the given context label, create a mapping to the given prefix."""
  mappings = {}
  for file in files:
    src = file.short_path
    # File in an external repo looks like:
    # '../WORKSPACE/SHORT_PATH'.  We want just the SHORT_PATH.
    if src.startswith("../"):
      parts = src.split("/")
      src = "/".join(parts[2:])
    dst = [prefix, label.package]
    name_parts = label.name.split(".")
    # special case to elide last part if the name is
    # 'go_default_library.pb'
    if name_parts[0] != "go_default_library":
      dst.append(name_parts[0])
    mappings[src] = "/".join(dst)

  return mappings


def _build_base_namespace(run, builder):
  pass


def _build_importmappings(run, builder):
  """Override behavior to add plugin options before building the --go_out option"""
  ctx = run.ctx
  go_prefix = run.lang.prefix

  opts = []
  # Add in the 'plugins=grpc' option to the protoc-gen-go plugin if
  # the user wants grpc.
  if run.data.with_grpc:
    opts.append("plugins=grpc")

  # Build the list of import mappings.  Start with any configured on
  # the rule by attributes.
  mappings = run.lang.importmap + run.data.importmap
  mappings += _get_mappings(run.data.protos, run.data.label, go_prefix)

  # Then add in the transitive set from dependent rules. TODO: just
  # pass the import map transitively rather than recomputing it.
  for unit in run.data.transitive_units:
    # Map to this go_prefix if within same workspace, otherwise use theirs.
    prefix = go_prefix if unit.data.workspace_name == run.data.workspace_name else unit.data.prefix
    mappings += _get_mappings(unit.data.protos, unit.data.label, prefix)

  if run.data.verbose > 1:
    print("go_importmap: %s" % mappings)

  for k, v in mappings.items():
    opts += ["M%s=%s" % (k, v)]

  builder[run.lang.name + "_pb_options"] += opts


def _build_plugin_out(name, outdir, options, builder):
  """Build the --{lang}_out argument for a given plugin."""
  arg = outdir
  if options:
    arg = ",".join(options) + ":" + arg
  builder["args"] += ["--%s_out=%s" % (name, arg)]


def _build_protobuf_out(run, builder):
  """Build the --{lang}_out option"""
  lang = run.lang
  name = lang.pb_plugin_name or lang.name
  outdir = builder.get(lang.name + "_outdir", run.outdir)
  options = builder.get(lang.name + "_pb_options", [])

  _build_plugin_out(name, outdir, options, builder)


def _build_grpc_out(run, builder):
  """Build the --{lang}_out grpc option"""
  lang = run.lang
  name = lang.grpc_plugin_name or "grpc-" + lang.name
  outdir = builder.get(lang.name + "_outdir", run.outdir)
  options = builder.get(lang.name + "_grpc_options", [])

  _build_plugin_out(name, outdir, options, builder)


def _get_outdir(ctx, lang, execdir):
  if ctx.attr.output_to_workspace:
    outdir = "."
  else:
    outdir = ctx.var["GENDIR"]
  return _get_offset_path(execdir, outdir)


def _get_external_roots(ctx):

  # Compte set of "external workspace roots" that the proto
  # sourcefiles belong to.
  external_roots = []
  for file in ctx.files.protos:
    path = file.path.split('/')
    if path[0] == 'external':
      external_roots += ["/".join(path[0:2])]

  # This set size must be 0 or 1. (all source files must exist in this
  # workspace or the same external workspace).
  roots = set(external_roots)
  if len(roots) > 1:
    fail(
"""
You are attempting simultaneous compilation of protobuf source files that span multiple workspaces (%s).
Decompose your library rules into smaller units having filesets that belong to only a single workspace at a time.
Note that it is OK to *import* across multiple workspaces, but not compile them as file inputs to protoc.
""" % roots
    )

  return list(roots)


def _compile(ctx, unit):

  execdir = unit.data.execdir

  protoc = _get_offset_path(execdir, unit.compiler.path)
  imports = ["--proto_path=" + _get_offset_path(execdir, i) for i in unit.imports]
  srcs = [_get_offset_path(execdir, p.path) for p in unit.data.protos]
  protoc_cmd = [protoc] + list(unit.args) + imports + srcs
  manifest = [f.short_path for f in unit.outputs]

  inputs = list(unit.inputs)
  outputs = list(unit.outputs)

  cmds = [" ".join(protoc_cmd)]
  if execdir != ".":
    cmds.insert(0, "cd %s" % execdir)

  if unit.data.output_to_workspace:
    print(
"""
>**************************************************************************
* - Generating files into the workspace...  This is potentially           *
*   dangerous (may overwrite existing files) and violates bazel's         *
*   sandbox policy.                                                       *
* - Disregard "ERROR: output 'foo.pb.*' was not created." messages.       *
* - Build will halt following the "not all outputs were created" message. *
* - Output manifest is printed below.                                     *
**************************************************************************<
%s
>*************************************************************************<
""" % "\n".join(manifest)
    )

  if unit.data.verbose:
    print(
"""
************************************************************
cd $(bazel info execution_root)%s && \
%s
************************************************************
%s
************************************************************
""" % (
  "" if execdir == "." else "/" + execdir,
  " \\ \n".join(protoc_cmd),
  "\n".join(manifest))
    )

  if unit.data.verbose > 2:
    for i in range(len(protoc_cmd)):
      print(" > cmd%s: %s" % (i, protoc_cmd[i]))
    for i in range(len(inputs)):
      print(" > input%s: %s" % (i, inputs[i]))
    for i in range(len(outputs)):
      print(" > output%s: %s" % (i, outputs[i]))

  ctx.action(
    mnemonic = "ProtoCompile",
    command = " && ".join(cmds),
    inputs = inputs,
    outputs = outputs,
  )


def _proto_compile_impl(ctx):

  if ctx.attr.verbose > 1:
    print("proto_compile %s:%s"  % (ctx.build_file_path, ctx.label.name))

  # Get list of external roots.
  external_roots = _get_external_roots(ctx)

  execdir = "." # test this with/without

  # Propogate proto deps compilation units.
  transitive_units = []
  for dep in ctx.attr.deps:
    for unit in dep.proto_compile_result.transitive_units:
        transitive_units.append(unit)

  # Immutable global state for this compiler run.
  data = struct(
    label = ctx.label,
    workspace_name = ctx.workspace_name,
    prefix = ":".join([ctx.label.package, ctx.label.name]),
    execdir = execdir,
    protos = ctx.files.protos,
    descriptor_set = ctx.outputs.descriptor_set,
    importmap = ctx.attr.importmap,
    pb_options = ctx.attr.pb_options,
    grpc_options = ctx.attr.grpc_options,
    verbose = ctx.attr.verbose,
    with_grpc = ctx.attr.with_grpc,
    transitive_units = transitive_units,
    output_to_workspace = ctx.attr.output_to_workspace,
  )

  #print("transitive_units: %s" % transitive_units)

  # Mutable global state to be populated by the classes.
  builder = {
    "args": [], # list of string
    "imports": ctx.attr.imports + [execdir] + external_roots,
    "inputs": ctx.files.protos,
    "outputs": [],
  }

  # Build a list of structs that will be processed in this compiler
  # run.
  runs = []
  for l in ctx.attr.langs:
    lang = l.proto_language

    exts = []
    if lang.supports_pb:
      exts += lang.pb_file_extensions
    if lang.supports_grpc and data.with_grpc:
      exts += lang.grpc_file_extensions

    runs.append(struct(
      ctx = ctx,
      outdir = _get_outdir(ctx, lang, execdir),
      lang = lang,
      data = data,
      exts = exts,
      output_to_jar = lang.output_to_jar,
    ))

    builder["inputs"] += lang.pb_inputs + lang.grpc_inputs
    builder["imports"] += lang.pb_imports + lang.grpc_imports
    builder[lang.name + "_pb_options"] = lang.pb_options + data.pb_options
    builder[lang.name + "_grpc_options"] = lang.grpc_options + data.grpc_options

    #print("grpc_inputs %s" % ctx.attr.grpc_inputs)

  _build_descriptor_set(data, builder)

  for run in runs:
    if run.lang.output_to_jar:
      _build_output_jar(run, builder)
    elif run.lang.output_to_library:
      _build_output_library(run, builder)
    elif run.lang.output_to_libdir:
      _build_output_libdir(run, builder)
    else:
      _build_output_files(run, builder)
    if run.lang.prefix:
      _build_importmappings(run, builder)
    if run.lang.supports_pb:
      _build_protobuf_invocation(run, builder)
      _build_protobuf_out(run, builder)

    if not run.lang.pb_plugin_implements_grpc and (data.with_grpc and run.lang.supports_grpc):
      _build_grpc_invocation(run, builder)
      _build_grpc_out(run, builder)

  # Build final immutable for rule and transitive beyond
  unit = struct(
    compiler = ctx.executable.protoc,
    data = data,
    args = set(builder["args"]),
    imports = set(builder["imports"]),
    inputs = set(builder["inputs"]),
    outputs = set(builder["outputs"] + [ctx.outputs.descriptor_set]),
  )

  # Run protoc
  _compile(ctx, unit)

  for run in runs:
    if run.lang.output_to_jar:
      _build_output_srcjar(run, builder)

  files = set(builder["outputs"])

  return struct(
    files = files,
    proto_compile_result = struct(
      unit = unit,
      transitive_units = transitive_units + [unit],
    ),
  )

proto_compile = rule(
  implementation = _proto_compile_impl,
  attrs = {
    "langs": attr.label_list(
      providers = ["proto_language"],
      allow_files = False,
      mandatory = True,
    ),
    "protos": attr.label_list(
      allow_files = FileType([".proto"]),
    ),
    "deps": attr.label_list(
      providers = ["proto_compile_result"]
    ),
    "protoc": attr.label(
      default = Label("//external:protoc"),
      cfg = "host",
      executable = True,
    ),
    "root": attr.string(),
    "imports": attr.string_list(),
    "importmap": attr.string_dict(),
    "inputs": attr.label_list(
      allow_files = True,
    ),
    "pb_options": attr.string_list(),
    "grpc_options": attr.string_list(),
    "output_to_workspace": attr.bool(),
    "verbose": attr.int(),
    "with_grpc": attr.bool(default = True),
  },
  outputs = {
    "descriptor_set": "%{name}.descriptor_set",
  },
  output_to_genfiles = True, # this needs to be set for cc-rules.
)
