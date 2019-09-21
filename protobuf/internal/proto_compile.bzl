def _file_endswith(file, suffix_list):
  """Test if a file ends with one of a list of suffixes
  Args:
    file (File): The file object.
    suffix_list(list<string>): a list of suffix token to test
  Returns:
    (boolean)
  """
  for suffix in suffix_list:
    if file.path.endswith(suffix):
      return True
  return False


def _capitalize(s):
  """Capitalize a string
  Args:
    s (string): The input string to be capitalized.
  Returns:
    (string): The capitalized string.
  """
  return s[0:1].upper() + s[1:]


def _pascal_case(s):
  """Convert pascal_case -> PascalCase
  Args:
    s (string): The input string to be capitalized.
  Returns:
    (string): The capitalized string.
  """
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


def _get_relative_dirname(run, base, file):
  """Return a dirname in the form of path segments relative to base.
  If the file.short_path is not within base, return empty list.
  Example: if base="foo/bar/baz.txt"
           and file.short_path="bar/baz.txt",
           return ["bar"].
  Args:
    run (struct): the compilation run object.
    base (string): the base dirname (ctx.label.package)
    file (File): the file to calculate relative dirname.
  Returns:
    (list<string>): path
  """
  path = file.dirname

  # dirname replaces an empty path with "." to match the behavior of
  # Linux's dirname(1). For the computations, below the "." is not necessary.
  if path == ".":
    path = ""

  # golang specific: If 'option go_package' is defined in the proto
  # file, protoc will output to that directory name rather than the
  # one based on the file path.  Since we cannot read/parse the file
  # as part of the bazel analysis phase, the user will have to put
  # this in manually.
  if run.data.go_package:
    path = run.data.go_package
    if path.endswith("/"):
      path = path[-1]
    parts = path.split("/")
    return parts

  if not path.startswith(base):
    build_path = run.ctx.build_file_path[:-len("BUILD")]
    # prepend offset between BUILD directory and file directory
    if file.path.startswith(build_path):
      return file.path[len(build_path):-len(file.basename)].split("/")
    #TODO is this a failing error?
    return []

  # At this point, path must start with base, so remove base
  relative_dir = path[len(base):]

  # Strip any leading slash, if present
  if relative_dir.startswith("/"):
    relative_dir = relative_dir[1:]

  # Check if relative_dir is empty, if so return empty list
  if relative_dir == "":
    return []

  parts = relative_dir.split("/")

  if parts[0] == "external":
    # ignore the first two items since we'll be cd'ing into
    # this dir.
    components = parts[2:]
    # If "go_package" is defined, the generated file will be created in
    # this subdirectory of the external dir.
    if run.data.go_package:
      components += run.data.go_package.split("/")
    return components

  return parts


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
  if filename.startswith("../"):
    filename = "external/" + filename[3:]
  library_path = _get_offset_path(run.data.execdir, filename)
  builder[name + "_pb_options"] += ["library=" + library_path]


def _build_output_srcjar(run, builder):
  ctx = run.ctx
  name = run.lang.name
  protojar = builder[name + "_jar"]
  srcjar_name = "%s_%s.srcjar" % (run.data.label.name, name)
  srcjar = ctx.new_file("%s_%s.srcjar" % (run.data.label.name, name))
  ctx.action(
    mnemonic = "CpJarToSrcJar",
    inputs = [protojar],
    outputs = [srcjar],
    command = "cp %s %s" % (protojar.path, srcjar.path),
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

    # If the source is a generated file, prefix the build file path with GENDIR
    generated_path = ctx.var["GENDIR"]
    build_package_path = ctx.label.package
    if file.path.startswith(generated_path):
      build_package_path = generated_path + "/" + build_package_path

    path = _get_relative_dirname(run, build_package_path, file)

    for ext in exts:
      temppath = list(path)
      temppath.append(base + ext)
      pbfile = ctx.new_file("/".join(temppath))
      builder["outputs"] += [pbfile]

    for pb_output in run.pb_outputs:
      pb_output = pb_output.format(basename = base)

      temppath = list(path)
      temppath.append(pb_output)
      pbfile = ctx.new_file("/".join(temppath))
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
  builder["args"] += ["--descriptor_set_out=" + _get_offset_path(data.execdir, data.descriptor_set.path)]


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


def _get_mappings(files, label, importpath):
  """For a set of files that belong to the given context label, create a mapping to the given prefix."""
  mappings = {}
  for file in files:
    src = file.short_path
    #print("mapping file short path: %s" % src)
    # File in an external repo looks like:
    # '../WORKSPACE/SHORT_PATH'.  We want just the SHORT_PATH.
    if src.startswith("../"):
      parts = src.split("/")
      src = "/".join(parts[2:])
    dst = [importpath]
    mappings[src] = "/".join(dst)
  return mappings


def _build_base_namespace(run, builder):
  pass


def _build_importmappings(run, builder, importpath):
  """Override behavior to add plugin options before building the --go_out option"""
  ctx = run.ctx
  opts = []

  # Build the list of import mappings.  Start with any configured on
  # the rule by attributes.
  mappings = dict(run.lang.importmap)
  mappings.update(run.data.importmap)
  mappings.update(_get_mappings(run.data.protos, run.data.label, importpath))

  # Then add in the transitive set from dependent rules.
  for unit in run.data.transitive_units:
    mappings.update(unit.transitive_mappings)

  if run.data.verbose > 1:
    print("go_importmap: %s" % mappings)

  for k, v in mappings.items():
    opts += ["M%s=%s" % (k, v)]

  builder["transitive_mappings"] = mappings

  # protoc-gen-go needs the importmapping in the protobuf options
  # whereas protoc-gen-grpc-gateway requires them in the grpc_options.
  if run.lang.pb_plugin_implements_grpc:
    # Add in the 'plugins=grpc' option to the protoc-gen-go plugin if
    # the user wants grpc.
    if run.data.with_grpc:
      opts.append("plugins=grpc")
    builder[run.lang.name + "_pb_options"] += opts
  else:
    builder[run.lang.name + "_grpc_options"] += opts


def _build_plugin_out(name, outdir, options, builder):
  """Build the --{lang}_out argument for a given plugin."""
  arg = outdir

  # If the outdir is external, such as when building
  # :well_known_protos, the protoc command may fail as the directory
  # bazel-out/local-fastbuild/genfiles/external/com_google_protobuf
  # won't necessarily exist.  Add this to the queue of pre-execution
  # commands to create it.
  if outdir.startswith("../..") and not outdir.endswith(".jar"):
    builder["commands"] += ["mkdir -p " + outdir]

  if options:
    arg = ",".join(options) + ":" + arg
  builder["args"] += ["--%s_out=%s" % (name, arg)]


def _build_protobuf_out(run, builder):
  """Build the --{lang}_out option"""
  lang = run.lang
  name = lang.pb_plugin_name or lang.name
  options = builder.get(lang.name + "_pb_options", [])

  if run.data.sources_are_generated:
    outdir = "."
  else:
    outdir = builder.get(lang.name + "_outdir", run.outdir)

  _build_plugin_out(name, outdir, options, builder)


def _build_grpc_out(run, builder):
  """Build the --{lang}_out grpc option"""
  lang = run.lang
  name = lang.grpc_plugin_name or "grpc-" + lang.name

  if run.data.sources_are_generated:
    outdir = "."
  else:
    outdir = builder.get(lang.name + "_outdir", run.outdir)

  options = builder.get(lang.name + "_grpc_options", [])

  _build_plugin_out(name, outdir, options, builder)


def _get_outdir(ctx, data):
  execdir = data.execdir
  if data.sources_are_generated and data.output_to_workspace:
    fail("output_to_workspace is not supported for generated proto files")
  if ctx.attr.output_to_workspace:
    outdir = "."
  else:
    outdir = ctx.var["GENDIR"]
  path = _get_offset_path(execdir, outdir)

  # If we are building generated files, the execdir and outdir are the same
  if path == "":
    return "."

  if execdir != ".":
    path += "/" + execdir

  if ctx.attr.root:
    path += "/" + ctx.attr.root

  return path


def _get_external_root(ctx):
  gendir = ctx.var["GENDIR"] + "/"

  # Complete set of "external workspace roots" that the proto
  # sourcefiles belong to.
  external_roots = []
  for file in ctx.files.protos:
    path = file.path
    if path.startswith(gendir):
      path = path[len(gendir):]
    path = path.split("/")
    if path[0] == "external":
      external_roots += ["/".join(path[0:2])]

  # This set size must be 0 or 1. (all source files must exist in this
  # workspace or the same external workspace).
  roots = depset(external_roots)
  if (ctx.attr.verbose > 2):
    print("external roots: %r" % roots)
  n = len(roots)
  if n:
    if n > 1:
      fail(
        """
        You are attempting simultaneous compilation of protobuf source files that span multiple workspaces (%s).
        Decompose your library rules into smaller units having filesets that belong to only a single workspace at a time.
        Note that it is OK to *import* across multiple workspaces, but not compile them as file inputs to protoc.
        """ % roots
      )
    else:
      return external_roots[0]
  else:
    return "."


def _update_import_paths(ctx, builder, data):
  """Updates import paths beginning with 'external' so that they point to external/."""
  execdir = data.execdir
  final_imports = []
  for i in builder["imports"]:
    final_i = i
    # Check for imports from external
    path = i.split("/")
    if path[0] == 'external':
      # Ensure that external imports start from root, as external/ does not exist when rule is being
      # built in an external project.
      final_i = _get_offset_path(execdir, i)
    final_imports.append(final_i)

  builder["imports"] = final_imports


def _compile(ctx, unit):

  execdir = unit.data.execdir

  protoc = _get_offset_path(execdir, unit.compiler.path)
  imports = ["--proto_path=" + i for i in unit.imports]
  srcs = [_get_offset_path(execdir, p.path) for p in unit.data.protos]
  protoc_cmd = [protoc] + list(unit.args) + imports + srcs
  manifest = [f.short_path for f in unit.outputs]

  transitive_units = depset(transitive = [u.inputs for u in unit.data.transitive_units])
  # for u in unit.data.transitive_units:
  #   print("____")
  #   print("before transitive_units: %s" % transitive_units)
  #   print("before u.inputs: %s" % u.inputs)

  #   transitive_units = transitive_units | u.inputs
  #   # transitive_units = depset(items = transitive_units, transitive = u.inputs)

  #   print("after transitive_units: %s" % transitive_units)

  print("____")
  print("unit.inputs: %s" % unit.inputs)
  print("transitive_units: %s" % transitive_units)
  print("unit.compiler: %s" % unit.compiler)

  # inputs = list(unit.inputs | transitive_units) + [unit.compiler]


  # inputs = depset(unit.inputs, transitive = [unit.compiler])

  compiler_dep = depset(direct = [unit.compiler])
  inputs = depset(direct = list(unit.inputs | transitive_units), transitive = [compiler_dep])
  print("inputs: %s" % inputs)

  outputs = list(unit.outputs)

  cmds = [cmd for cmd in unit.commands] + [" ".join(protoc_cmd)]
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

  if unit.data.verbose > 3:
    cmds += ["find ../../"]

  ctx.action(
    mnemonic = "ProtoCompile",
    command = " && ".join(cmds),
    inputs = inputs,
    outputs = outputs,
  )


def _check_if_protos_are_generated(ctx):
  generated_path = ctx.var["GENDIR"]
  all_generated = True
  all_source = True
  for f in ctx.files.protos:
    if not f.path.startswith(generated_path):
      all_generated = False
    if not f.is_source:
      all_source = False
  if all_source:
    return False
  if all_generated:
    return True

  fail(
    """
    You are attempting simultaneous compilation of protobuf source files and generated protobuf files.
    Decompose your library rules into smaller units having filesets that are only source files or only
    generated files.
    """
  )

def  _add_imports_for_transitive_units(ctx, data, builder):
  proto_paths = [ data.execdir ]
  for unit in data.transitive_units:
    if len(unit.data.protos) == 0:
      continue
    if unit.data.execdir not in proto_paths:
      builder["imports"].append(_get_offset_path(data.execdir, unit.data.execdir))
      proto_paths.append(unit.data.execdir)


def _proto_compile_impl(ctx):

  if ctx.attr.verbose > 1:
    print("proto_compile %s:%s" % (ctx.build_file_path, ctx.label.name))

  # Calculate list of external roots and return the base directory
  # we'll use for the protoc invocation.  Usually this is '.', but if
  # not, its 'external/WORKSPACE'
  execdir = _get_external_root(ctx)

  # If we are building generated protos, run from gendir.
  sources_are_generated = _check_if_protos_are_generated(ctx)
  if sources_are_generated:
    external = "" if execdir == "." else "/" + execdir
    execdir = ctx.var["GENDIR"] + external

  # Propagate proto deps compilation units.
  transitive_units = []
  for dep in ctx.attr.deps:
    for unit in dep.proto_compile_result.transitive_units:
        transitive_units.append(unit)


  # Make the proto list.
  # First include any protos that match cts.attr.includes.
  # Then exclude any protos that match ctx.attr.excludes.
  includes = []
  protos = []

  if ctx.attr.includes:
    for file in ctx.files.protos:
      if _file_endswith(file, ctx.attr.includes):
        includes.append(file)
      else:
        continue
  else:
    includes = ctx.files.protos

  if ctx.attr.excludes:
    for file in includes:
      if _file_endswith(file, ctx.attr.excludes):
        continue
      else:
        protos.append(file)
  else:
    protos = includes

  # Immutable global state for this compiler run.
  data = struct(
    label = ctx.label,
    workspace_name = ctx.workspace_name,
    go_package = ctx.attr.go_package,
    execdir = execdir,
    protos = protos,
    descriptor_set = ctx.outputs.descriptor_set,
    importmap = ctx.attr.importmap,
    pb_options = ctx.attr.pb_options,
    grpc_options = ctx.attr.grpc_options,
    verbose = ctx.attr.verbose,
    with_grpc = ctx.attr.with_grpc,
    transitive_units = transitive_units,
    output_to_workspace = ctx.attr.output_to_workspace,
    sources_are_generated = sources_are_generated,
  )

  # Mutable global state to be populated by the classes.
  builder = {
    "args": [], # list of string
    "imports": ctx.attr.imports + ["."],
    "inputs": ctx.files.protos + ctx.files.inputs,
    "outputs": [],
    "commands": [], # optional miscellaneous pre-protoc commands
  }

  _add_imports_for_transitive_units(ctx, data, builder)

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

    pb_outputs = []
    if lang.supports_pb:
      pb_outputs += lang.pb_outputs

    runs.append(struct(
      ctx = ctx,
      outdir = _get_outdir(ctx, data),
      lang = lang,
      data = data,
      exts = exts,
      pb_outputs = pb_outputs,
      output_to_jar = lang.output_to_jar,
    ))

    builder["inputs"] += lang.pb_inputs + lang.grpc_inputs
    builder["imports"] += lang.pb_imports + lang.grpc_imports
    builder[lang.name + "_pb_options"] = lang.pb_options + data.pb_options
    builder[lang.name + "_grpc_options"] = lang.grpc_options + data.grpc_options

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
    if ctx.attr.go_importpath: # golang-specific
      _build_importmappings(run, builder, ctx.attr.go_importpath)
    if run.lang.supports_pb:
      _build_protobuf_invocation(run, builder)
      _build_protobuf_out(run, builder)
    if not run.lang.pb_plugin_implements_grpc and (data.with_grpc and run.lang.supports_grpc):
      _build_grpc_invocation(run, builder)
      _build_grpc_out(run, builder)

  _update_import_paths(ctx, builder, data)

  # Build final immutable compilation unit for rule and transitive beyond
  unit = struct(
    compiler = ctx.executable.protoc,
    data = data,
    transitive_mappings = builder.get("transitive_mappings", {}),
    args = depset(builder["args"] + ctx.attr.args),
    imports = depset(builder["imports"]),
    inputs = depset(builder["inputs"]),
    outputs = depset(builder["outputs"] + [ctx.outputs.descriptor_set]),
    commands = depset(builder["commands"]),
  )

  # Run protoc
  _compile(ctx, unit)

  for run in runs:
    if run.lang.output_to_jar:
      _build_output_srcjar(run, builder)

  files = depset(builder["outputs"])

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
    "args": attr.string_list(),
    "langs": attr.label_list(
      providers = ["proto_language"],
      allow_files = False,
      mandatory = False,
    ),
    "protos": attr.label_list(
      allow_files = [".proto"],
    ),
    "includes": attr.string_list(),
    "excludes": attr.string_list(),
    "deps": attr.label_list(
      providers = ["proto_compile_result"]
    ),
    "protoc": attr.label(
      default = Label("//external:protocol_compiler"),
      cfg = "host",
      executable = True,
    ),
    "go_importpath": attr.string(),
    "go_package": attr.string(),
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
