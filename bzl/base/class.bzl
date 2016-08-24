def implement_compile_attributes(lang, self):
    """Add attributes for the X_proto_compile rule"""

    name = lang.name
    attrs = self["attrs"]

    # Add "gen_java = X" option where X is True if this is the first
    # language specified.
    flag = "gen_" + name
    attrs[flag] = attr.bool(
        default = True,
    )

    # Add a "gen_java_plugin_options=[]".
    opts = flag + "_plugin_options"
    attrs[opts] = attr.string_list()

    # If there is a plugin binary, create this label now.
    if hasattr(lang, "protobuf") and hasattr(lang.protobuf, "executable"):
        attrs["gen_protobuf_" + name + "_plugin"] = attr.label(
            default = Label(lang.protobuf.executable),
            cfg = HOST_CFG,
            executable = True,
        )

    # If this language supports gRPC, add this boolean flag in.
    # However, if we didn't load grpc, we don't actually want to
    # generate the label for the executable lest we actually need to
    # have the executable available.  TODO: figure out how to write a
    # variable in the loading phase of workspace and read it here.

    if hasattr(lang, "grpc"):
      attrs["gen_grpc_" + name] = attr.bool()
      if hasattr(lang.grpc, "executable"):
        attrs["gen_grpc_" + name + "_plugin"] = attr.label(
          default = Label(lang.grpc.executable),
          cfg = HOST_CFG,
          executable = True,
        )


def implement_compile_outputs(lang, self):
    """Add customizable outputs for the proto_compile rule"""
    if hasattr(lang, "protobuf") and hasattr(lang.protobuf, "outputs"):
        self["outputs"] += lang.protobuf.outputs
    if hasattr(lang, "grpc") and hasattr(lang.grpc, "outputs"):
        self["outputs"] += lang.grpc.outputs


def implement_compile_output_to_genfiles(lang, self):
    self["output_to_genfiles"] = getattr(lang, "output_to_genfiles", self["output_to_genfiles"])


def get_generated_filename_extensions(lang, self):
    ctx = self.get("ctx", None)
    with_grpc = self["with_grpc"]
    exts = []

    if hasattr(lang, "protobuf"):
        exts += getattr(lang.protobuf, "file_extensions", [])

    if with_grpc or getattr(ctx.attr, "gen_grpc_" + lang.name, False):
        if hasattr(lang, "grpc"):
            exts += getattr(lang.grpc, "file_extensions", [])

    return exts


def build_generated_files(lang, self):
    """Build a list of generated filenames (used by rule)"""
    exts = get_generated_filename_extensions(lang, self)

    ctx = self.get("ctx", None)
    if ctx.attr.verbose > 1:
        print("generated_file extensions for language %s: %s" % (lang.name, exts))

    if not exts:
        return

    if ctx == None:
        fail("build_generated_files can only be used in bazel context")

    protos = self.get("srcs", [])
    if not protos:
        fail("Empty proto file input list.")

    for srcfile in protos:
        base = srcfile.basename[:-len(".proto")]
        for ext in exts:
            pbfile = ctx.new_file(base + ext)
            self["provides"] += [pbfile]


def build_imports(lang, self):
    """Build the list of imports"""
    ctx = self["ctx"]
    self["imports"] = self.get("imports", []) + ctx.attr.imports


def build_plugin_out(name, key, lang, self):
    #print("build_plugin_out(%s, %s)" % (name, key))
    if not hasattr(lang, key):
        return
    plugin = getattr(lang, key)
    opts = getattr(plugin, "default_options", [])
    opts += self.get(key + "_plugin_options", [])
    outdir = self["outdir"]
    if opts:
        outdir = ",".join(opts) + ":" + outdir
    self["args"] += ["--%s_out=%s" % (name, outdir)]


def build_protobuf_out(lang, self):
    """Build the --{lang}_out option"""
    build_plugin_out(lang.name, "protobuf", lang, self)


def build_grpc_out(lang, self):
    """Build the --grpc_out option if required"""
    build_plugin_out("grpc", "grpc", lang, self)


def build_plugin_invocation(key, lang, self):
    """Add a '--plugin=NAME=PATH' argument if the language descriptor
    requires one.  key can be 'protobuf' or 'grpc'
    """

    if not hasattr(lang, key):
        return

    plugin = getattr(lang, key)
    if not hasattr(plugin, "executable"):
        return

    ctx = self.get("ctx")
    plugin_binary = self.get("gen_" + key + "_" + lang.name + "_plugin", plugin.executable)
    location = None

    #print("plugin binary %s" % plugin_binary)

    # If we are in the context of a genrule...
    if ctx == None:
        location = "$(location %s)" % plugin_binary
    else:
        # If we are in the context of a rule, we need to get the value
        # from the ctx.executable struct.
        attrkey = "gen_" + key + "_" + lang.name + "_plugin"

        if not hasattr(ctx.executable, attrkey):
            fail("Plugin executable not found: %s" % attrkey)

        file = getattr(ctx.executable, attrkey)
        location = file.path
        self["requires"] += [file]

    #print(key + " location: %s" % location)
    self["args"] += ["--plugin=%s=%s" % (plugin.name, location)]


def build_grpc_invocation(lang, self):
    """Build a --plugin option if required for grpc service generation"""
    build_plugin_invocation("grpc", lang, self)


def build_protobuf_invocation(lang, self):
    """Build a --plugin option if required for basic protobuf generation"""
    build_plugin_invocation("protobuf", lang, self)


def build_protoc_command(lang, self):
    """Build a command list required for genrule execution"""
    self["cmd"] += ["$(location %s)" % self["protoc"]]
    self["cmd"] += ["--proto_path=" + i for i in self["imports"]]
    self["cmd"] += self["args"]
    self["cmd"] += ["$(location " + proto + ")" for proto in self["protos"]]


def build_inputs(lang, self):
    """Build a list of inputs to the ctx.action protoc"""
    self["requires"] += self["srcs"]


def post_execute(lang, self):
    """No default post-execute actions"""
    pass


CLASS = struct(
    name = "base",

    protobuf = struct(
        requires = [
            "protobuf",
            "external_protoc",
            "third_party_protoc",
        ]
    ),

    build_generated_files = build_generated_files,
    build_imports = build_imports,
    build_inputs = build_inputs,
    build_protobuf_invocation = build_protobuf_invocation,
    build_protobuf_out = build_protobuf_out,
    build_grpc_out = build_grpc_out,
    build_grpc_invocation = build_grpc_invocation,
    build_protoc_command = build_protoc_command,

    post_execute = post_execute,

    implement_compile_attributes = implement_compile_attributes,
    implement_compile_outputs = implement_compile_outputs,
    implement_compile_output_to_genfiles = implement_compile_output_to_genfiles,
)
