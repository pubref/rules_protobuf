def _describe(obj, name = "struct", exclude = ["output_group"]):
    """Print the properties of the given struct obj, for debugging
    Args:
      name: the name of the struct we are introspecting.
      obj: the struct to introspect
      exclude: a list of names *not* to print (function names)
    """
    for k in dir(obj):
        if hasattr(obj, k) and k not in exclude:
            v = getattr(obj, k)
            t = type(v)
            print("\n%s.%s<%r> = %s" % (name, k, t, v))


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


def _create_output_file(run, builder, path, basename, ext):
  path.append(basename + ext)
  filename = "/".join(path)
  genfile = run.ctx.new_file(filename)
  builder["outputs"] += [genfile]
  #print("created output file %s, %s, %s" % (path, basename, ext))
  return genfile


def _build_go_package_output_file(run, builder, file, basename, ext):

  ####
  # 1. Define go_prefix from the go_package option.
  #
  dirname = run.data.go_package
  if dirname.endswith("/"):
    dirname = dirname[-1]
  path = dirname.split("/")
  go_prefix = "/".join(path)

  ####
  # 2. Declare the generated file.
  #
  genfile = _create_output_file(run, builder, path, basename, ext)

  ####
  # 3. Add an entry to the importmap.
  #
  # Example1: If the file.short path is "google/api/label.proto", the
  # go_prefix containing the rule is
  # "google.golang.org/genproto/googleapis", the label_package is ""
  # (BUILD file is in the root of the workspace), label_name is
  # "label_proto.pb" (from prefixing basename above), the desired
  # importmapping is "google/api/label.proto" -->
  # "GO_PREFIX/LABEL_PACKAGE/LABEL_NAME" or
  # "google.golang.org/genproto/googleapis/label_go_proto"

  label_package = file.dirname
  label_name = run.ctx.label.name

  # Exclude the package label if not defined or '.'
  dst = [go_prefix]
  if label_package and not label_package == ".":
    dst.append(label_package)
  dst.append(label_name)

  src_path = file.short_path
  dst_path = "/".join(dst)
  # print("> src_path %s" % src_path)
  # print("> dst_path %s" % dst_path)

  # Add an entry to the importmap.  The presence of this entry we are
  # about to make will override the one that would otherwise be
  # created in the _build_importmappings code path.
  importmap = builder["importmap"]
  importmap[src_path] = dst_path


  ####
  # 4. Copy the actual generated file to the expected location.
  #
  # Protoc respects the go_package option and will generate the file
  # in a location that is outside the package boundary of the defining
  # go_proto_library rule.  We need to add a post-compilation step to
  # copy the actual generated file to the one expected by bazel.
  actual = [genfile.root.path, go_prefix, basename + ext]
  if label_package.startswith("external/"):
    external_dir = "/".join(label_package.split("/")[:2])
    actual.insert(1, external_dir)
  actual_path = _get_offset_path(run.data.execdir, "/".join(actual))
  expected_path = _get_offset_path(run.data.execdir, genfile.path)
  if actual_path != expected_path:
    #print("cp %s %s" % (actual_path, expected_path))
    builder["post_commands"] += ["cp %s %s" % (actual_path, expected_path)]


def _build_external_output_file(run, builder, file, path, basename, ext):
  #print("_build_package_external_output_file(run=, builder, file=%s, path=%s, basename=%s, ext=%s)"
  #      % (file.path, path, basename, ext))

  # ignore the first two items since we'll be cd'ing into this dir.
  path = path[2:]

  # The go_package option overrides the package_label dir.
  if run.data.go_package:
    _build_go_package_output_file(run, builder, file, basename, ext)
  else:
    if "/".join(path).startswith(run.ctx.label.package):
      _create_output_file(run, builder, path, basename, ext)
    else:
      _build_orphaned_output_file(run, builder, file, path, basename, ext)


def _build_internal_output_file(run, builder, file, path, basename, ext):
  #print("_build_internal_output_file(run=, builder, file=%s, path=%s, basename=%s, ext=%s)"
  #      % (file.path, path, basename, ext))
  if run.data.go_package:
    _build_go_package_output_file(run, builder, file, basename, ext)
  else:
    if file.dirname == '.':
      path = []
    # The ctx.new_file action will create a file in the package
    # namespace of the label.  Therefore, we want to strip the package
    # prefix of the path before handing it off the ctx.new_file.
    # This is true UNLESS the label is in the root BUILD file.  In that case,
    # run.ctx.label.package.split("/") results in [""] (an array of length 1),
    # which then has the buggy behavior of stripping the first element if the path,
    # regardless of the value if used.
    label_package = run.ctx.label.package
    if label_package:
      package_path = label_package.split("/")
      path = path[len(package_path):]

    _create_output_file(run, builder, path, basename, ext)


def _build_orphaned_output_file(run, builder, file, path, basename, ext):
  # If we find a file whose path is outside the package label, we
  # will need to copy the actual generated file back to its expected location.
  # NOTE: this is not really working yet, and why the native proto rules
  # disallow it.
  expected_file = _create_output_file(run, builder, path, basename, ext)
  actual_filename = "/".join(path)
  #print("build_orphan(exp=%s,act=%s)" % (expected_file.path, actual_filename))
  builder["post_commands"] += ["cp %s ../../%s" % (actual_filename, expected_file.path)]


def _build_output_file(run, builder, file, basename, ext):
  """Return a dirname in the form of path segments relative to base.
  If the file.short_path is not within base, return empty list.
  Example: if base="foo/bar/baz.txt"
           and file.short_path="bar/baz.txt",
           return ["bar"].
  Args:
    run (struct): the compilation run object.
    package_label (string): the base dirname (ctx.label.package)
    file (File): the file to build output pb file for
  """
  path = file.dirname.split("/")

  if path[0] == "external":
    _build_external_output_file(run, builder, file, path, basename, ext)
  else:
    _build_internal_output_file(run, builder, file, path, basename, ext)


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
    basename = file.basename[:-len(".proto")]
    if run.lang.output_file_style == 'pascal':
      basename = _pascal_case(basename)
    if run.lang.output_file_style == 'capitalize':
      basename = _capitalize(basename)
    for ext in exts:
      _build_output_file(run, builder, file, basename, ext)


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


def _add_importmapping(mappings, src, label_package, label_name, go_prefix):
  # File in an external repo looks like:
  # '../WORKSPACE/SHORT_PATH'.  We want just the SHORT_PATH.
  if src.startswith("../"):
    parts = src.split("/")
    src = "/".join(parts[2:])

  dst = [go_prefix]

  if label_package:
    dst.append(label_package)

  name_parts = label_name.split(".")

  # special case to elide last part if the name is
  # 'go_default_library.pb'
  if name_parts[0] != "go_default_library":
    dst.append(name_parts[0])

  current_value = mappings.get(src)

  if not current_value:
    mappings[src] = "/".join(dst)
  #else: print("refusing to override pre-existing importmapping: %s=%s" % (src, current_value))


def _add_importmappings(mappings, files, label, go_prefix):
  """For a set of files that belong the the given context label, create a mapping to the given prefix."""
  for file in files:
    _add_importmapping(mappings, file.short_path, label.package, label.name, go_prefix)


def _build_importmappings(run, builder):
  """Override behavior to add plugin options before building the --go_out option"""
  ctx = run.ctx
  go_prefix = run.data.go_prefix or run.lang.go_prefix
  opts = []

  # Build the list of import mappings.  Start with any configured on
  # the rule by attributes.
  mappings = run.lang.importmap + run.data.importmap + builder["importmap"]
  _add_importmappings(mappings, run.data.protos, run.data.label, go_prefix)

  # Then add in the transitive set from dependent rules.
  for unit in run.data.transitive_units:
    mappings += unit.transitive_mappings

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
  # bazel-out/local-fastbuild/genfiles/external/com_github_google_protobuf
  # won't necessarily exist.  Add this to the queue of
  # pre-execution commands to create it.
  if outdir.startswith("../..") and not outdir.endswith(".jar"):
    builder["pre_commands"] += ["mkdir -p " + outdir]

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
  path = _get_offset_path(execdir, outdir)
  if execdir != ".":
    path += "/" + execdir
  if ctx.attr.root:
    path += "/" + ctx.attr.root
  return path


def _get_external_root(ctx):

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
  root = None

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
      root = external_roots[0]
  else:
    root = "."

  if ctx.attr.root:
    root = "/".join([root, ctx.attr.root])

  return root


def _compile(ctx, unit):

  execdir = unit.data.execdir

  protoc = _get_offset_path(execdir, unit.compiler.path)
  imports = ["--proto_path=" + i for i in unit.imports]
  srcs = [_get_offset_path(execdir, p.path) for p in unit.data.protos]
  protoc_cmd = [protoc] + list(unit.args) + imports + srcs
  manifest = [f.short_path for f in unit.outputs]

  transitive_units = set()
  for u in unit.data.transitive_units:
    transitive_units = transitive_units | u.inputs
  inputs = list(unit.inputs | transitive_units) + [unit.compiler]
  outputs = list(unit.outputs)

  cmds = [cmd for cmd in unit.pre_commands] + [" ".join(protoc_cmd)] + [cmd for cmd in unit.post_commands]
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
    for i in range(len(cmds)):
      print(" > cmd%s: %s" % (i, cmds[i]))
    for i in range(len(protoc_cmd)):
      print(" > arg%s: %s" % (i, protoc_cmd[i]))
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


def _add_well_known_proto_imports(data, builder):
  imports = builder["imports"]
  wkt_import = "external/com_github_google_protobuf/src"
  if data.execdir == "external/com_github_google_protobuf":
    if wkt_import in imports:
      imports.remove(wkt_import)
      imports.insert(0, "src")

  builder["imports"] = imports


def _proto_compile_impl(ctx):

  if ctx.attr.verbose > 1:
    print("proto_compile %s:%s"  % (ctx.build_file_path, ctx.label.name))

  # Calculate list of external roots and return the base directory
  # we'll use for the protoc invocation.  Usually this is '.', but if
  # not, its 'external/WORKSPACE'
  execdir = _get_external_root(ctx)

  # Propogate proto deps compilation units.
  transitive_units = []

  for dep in ctx.attr.deps:
    for unit in dep.proto_compile_result.transitive_units:
      transitive_units.append(unit)

  # Assign go_prefix if exists
  if ctx.attr.go_prefix:
    go_prefix = ctx.attr.go_prefix.go_prefix
  else:
    go_prefix = ""


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
    go_prefix = go_prefix,
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
  )

  #print("transitive_units: %s" % transitive_units)

  # Mutable global state to be populated by the classes.
  builder = {
    "args": [], # list of string
    "imports": ctx.attr.imports,
    "importmap": {},
    "inputs": ctx.files.protos + ctx.files.inputs,
    "outputs": [],
    "pre_commands": ctx.attr.pre_commands, # optional miscellaneous pre-protoc commands
    "post_commands": ctx.attr.post_commands, # optional miscellaneous post-protoc commands
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
    if run.lang.go_prefix: # golang-specific
      _build_importmappings(run, builder)
    if run.lang.supports_pb:
      _build_protobuf_invocation(run, builder)
      _build_protobuf_out(run, builder)
    if not run.lang.pb_plugin_implements_grpc and (data.with_grpc and run.lang.supports_grpc):
      _build_grpc_invocation(run, builder)
      _build_grpc_out(run, builder)

  _add_well_known_proto_imports(data, builder)

  # Build final immutable compilation unit for rule and transitive beyond
  unit = struct(
    compiler = ctx.executable.protoc,
    data = data,
    transitive_mappings = builder.get("transitive_mappings", {}),
    args = set(builder["args"] + ctx.attr.args),
    imports = set(builder["imports"] + ["."]),
    inputs = set(builder["inputs"]),
    outputs = set(builder["outputs"] + [ctx.outputs.descriptor_set]),
    pre_commands = set(builder["pre_commands"]),
    post_commands = set(builder["post_commands"]),
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
    # Arbitrary arguments to protoc
    "args": attr.string_list(),

    # List of proto_compile dependent rules
    "deps": attr.label_list(
      providers = ["proto_compile_result"]
    ),

    # List of strings that filter the protos list
    # (matches via endswith)
    "excludes": attr.string_list(),

    # A string that positively shifts the execution directory
    # relative to the computed workspace execdir.
    "execdir": attr.string(),

    # Used to explicitly declare the 'go_package' option if the proto files uses it.
    "go_package": attr.string(),

    # Label to the 'go_prefix' (rules_go specific)
    "go_prefix": attr.label(
      providers = ["go_prefix"],
    ),

    # List of additional options to the grpc compile action
    "grpc_options": attr.string_list(),

    # List if imports relative to the execdir
    "imports": attr.string_list(),

    # List of importmappings (golang specific)
    "importmap": attr.string_dict(),

    # List of strings that filter the protos list
    # (matches via endswith)
    "includes": attr.string_list(),

    # List of labels to include in the ProtoCompile ctx.action, needed for exposing
    # additinal files in the sandbox.
    "inputs": attr.label_list(
      allow_files = True,
    ),

    # List of labels that specify a proto_language
    "langs": attr.label_list(
      providers = ["proto_language"],
      allow_files = False,
      mandatory = False,
    ),

    # Generate proto files in the workspace itself (so that they can
    # be checked into version control if you so choose (probably you
    # should not do this).
    "output_to_workspace": attr.bool(),

    # List of additional options to the pb compile action
    "pb_options": attr.string_list(),

    # Arbitrary arguments to run after the protoc command
    "post_commands": attr.string_list(),

    # Arbitrary arguments to run before the protoc command
    "pre_commands": attr.string_list(),

    # List of proto files
    "protos": attr.label_list(
      allow_files = FileType([".proto"]),
    ),

    # Label to the protocol compiler
    "protoc": attr.label(
      default = Label("//external:protoc"),
      cfg = "host",
      executable = True,
    ),

    # The root, shift the working directory of all commands to this dir.
    "root": attr.string(),

    # Print more debugging information.
    "verbose": attr.int(),

    # Generate service definitions
    "with_grpc": attr.bool(default = True),
  },
  outputs = {
    "descriptor_set": "%{name}.descriptor_set",
  },
  output_to_genfiles = True, # this needs to be set for cc-rules.
)
