load("//bzl:languages.bzl", "LANGUAGES")

def build_compile_attributes(spec):

  attrs = {}
]
  attrs["verbose"] = attr.int(
    default = 0,
  )

  # The set of files to compile
  attrs["protos"] = attr.label_list(
    allow_files = FileType([".proto"]),
  )

  # ? How to deps interact here?  Don't understand this. Provider
  # aspect is "proto".
  attrs["deps"] = attr.label_list(providers = ["proto"])

  # Additional include options to protoc.  These should be
  # directories.  TODO(user): should this be typed as directory only?
  attrs["includes"] = attr.string_list()

  # The list of files the rule generates.  How is this actually being
  # used?
  attrs["outs"] = attr.output_list()

  # The protoc executable (built from source by default)
  attrs["protoc"] = attr.label(
    default = Label("//external:protoc"),
    # TODO: isn't HOST_CFG deprecated?
    cfg = HOST_CFG,
    executable = True,
  )

  # Support for protoc plugins not defined here.
  attrs["plugin_name"] = attr.string()
  attrs["plugin_args"] = attr.string_list()
  attrs["plugin_binary"] = attr.string_list()
  attrs["plugin_generated_file_extension"] = attr.string_list()

  # Generate the descriptor? Shouldn't we just always generate this?
  #attrs["with_descriptor"] = attr.bool()

  # ================================================================
  # Flags for registered languages
  # ================================================================

  # Add (for example) "gen_java = False" and "gen_java_options=[]"
  # foreach language.  If the lang descriptor has a "plugin_binary
  # attribute", add that in.
  for name in spec:
    lang = LANGUAGES.get(name)
    if not lang: fail("Language not defined: %s" % name)

    # Add "gen_java = True" option
    flag = "gen_" + name
    attrs[flag] = attr.bool(
        default = False,
    )

    # Add a "gen_java_plugin_options=[]".
    opts = flag + "_plugin_options"
    attrs[opts] = attr.string_list()

    # If there is a plugin binary, create this label now.
    if hasattr(lang, "protobuf") and hasattr(lang.protobuf, "executable"):
      attrs["gen_" + name + "_protobuf_plugin_executable"] = attr.label(
        default = Label(lang.protobuf.executable),
        cfg = HOST_CFG,
        executable = True,
      )

    # If this language supports gRPC, add this boolean flag in.
    if hasattr(lang, "grpc"):
      attrs["gen_grpc_" + name] = attr.bool()
      if hasattr(lang.grpc, "executable"):
        attrs["gen_" + name + "_grpc_plugin_executable"] = attr.label(
          default = Label(lang.grpc.executable),
          cfg = HOST_CFG,
          executable = True,
        )

  #print("attrs: %s" % attrs.keys())
  return attrs


def implement_compile(spec, attrs={}):
  return rule(
    implementation = _execute_compile,
    attrs = build_compile_attributes(spec),
    outputs = {
      #"descriptor_set": "%{name}_descriptor.proto",
    },
    output_to_genfiles = True,
  )



def get_path(ctx, path):
  if ctx.label.workspace_root:
    return ctx.label.workspace_root + '/' + path
  else:
    return path


def get_gendir(ctx):
  return ctx.var["GENDIR"] + "/" + ctx.label.package
  # if not ctx.attr.includes:
  #   return ctx.label.workspace_root
  # if not ctx.attr.includes[0]:
  #   return get_path(ctx, ctx.label.package)
  # if not ctx.label.package:
  #   return get_path(ctx, ctx.attr.includes[0])
  # return get_path(ctx, ctx.label.package + '/' + ctx.attr.includes[0])


def build_source_files(ctx, self):
  # Copy the proto source to the gendir namespace (where the
  # BUILD rule is called).
  for srcfile in ctx.files.protos:
    protofile = ctx.new_file(srcfile.basename)
    if self["verbose"]:
      print("Copying %s .. %s" % (srcfile.path, protofile.path))
    ctx.action(
      mnemonic = "CpProtoToPackageGengiles",
      inputs = [srcfile],
      outputs = [protofile],
      arguments = [srcfile.path, protofile.path],
      command = "cp $1 $2")
    self["srcs"] += [protofile]
    self["imports"] += [protofile.dirname]


def _execute_compile(ctx):

  self = {
    "gendir": get_gendir(ctx),
    "imports": [],
    "args": [],
    "srcs": [],
    "requires": [],
    "provides": [],
    #"descriptor_set_file": descriptor_set_file,
  }

  # Propogate proto deps
  for dep in ctx.attr.deps:
    self["imports"] += dep.proto.imports
    self["requires"] += dep.proto.deps
    self["srcs"] += dep.proto.srcs

  # Copy source files over to gendir
  build_source_files(ctx, self)

  # Make a list of languages that were specified for this run
  spec = []
  for name, lang in LANGUAGES.items():
    if getattr(ctx.attr, "gen_" + name, False):
      spec += [lang]

  # Arguments to satisfy the *.descriptor.proto implicit output target
  #descriptor_set_filename = ctx.label.name + "_descriptor.proto"
  #descriptor_set_file = ctx.new_file(descriptor_set_filename)
  #provides += [descriptor_set_file]

  # Prepreprocessing for all requested languages.
  for lang in spec:
    invoke("build_imports_ctx", lang, builder, ctx)
    invoke("build_provided_pb_files_ctx", lang, builder, ctx)
    invoke("build_protobuf_invocation_ctx", lang, builder, ctx)
    invoke("build_grpc_invocation_ctx", lang, builder, ctx)
    invoke("build_provided_pb_files_ctx", lang, builder, ctx)
    invoke("build_protoc_arguments_ctx", lang, builder, ctx)

    # _build_imports = getattr(lang, "build_imports", build_imports)
    # _build_imports(ctx, lang, self)

    # _build_plugin_invocation = getattr(lang, "build_plugin_invocation", build_plugin_invocation)
    # _build_plugin_invocation(ctx, lang, self)

    # _build_provided_pb_files = getattr(lang, "build_provided_pb_files", build_provided_pb_files)
    # _build_provided_pb_files(ctx, lang, self)

    # _build_grpc_invocation = getattr(lang, "build_grpc_invocation", build_grpc_invocation)
    # _build_grpc_invocation(ctx, lang, self)

    # _build_protoc_arguments = getattr(lang, "build_protoc_arguments", build_protoc_arguments)
    # _build_protoc_arguments(ctx, lang, self)

  # Run protoc
  invoke("execute_protoc_rule", lang, builder, ctx)

  # Postprocessing
  #
  for lang in spec:
    invoke("post_execute", lang, builder)

  return struct(
    files=set(self["provides"]),
    proto=struct(
      srcs = set(self["srcs"]),
      imports = self["imports"],
      deps = self["requires"],
    ),
  )
