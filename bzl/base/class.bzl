def build_generated_filenames(lang, self):
    """Build a list of generated filenames (used by genrule)"""

    if not hasattr(lang, "protobuf"):
        fail("Required struct 'protobuf' not found in lang %s" % lang.name)

    if not hasattr(lang.protobuf, "file_extensions"):
      fail("Required string_list 'file_extensions' not found in protobuf struct %s" % lang.protobuf)

    exts = getattr(lang.protobuf, "file_extensions")

    with_grpc = self.get("with_grpc", False)
    ctx = self.get("ctx", None)
    if ctx != None:
        with_grpc = getattr(ctx.attr, "gen_grpc_" + lang.name, False)

    if with_grpc:
        if not hasattr(lang, "grpc"):
            fail("Language %s does not support gRPC" % lang.name)
        exts += getattr(lang.grpc, "file_extensions", [])

    print("source protos: %s" % self["protos"])
    for srcfile in self.get("protos", []):
        if not srcfile.endswith('.proto'):
            fail("Non .proto source file: %s" % srcfile, "protos")
        for ext in exts:
            self["outs"] += [srcfile.rsplit('.', 1)[0] + ext]


def build_imports(lang, self):
    """Build the list of imports"""
    pass


def build_plugin_out(name, key, lang, self):
    if not hasattr(lang, key):
        return
    plugin = getattr(lang, key)
    opts = getattr(plugin, "default_options", [])
    opts += self.get(key + "_plugin_options", [])
    outdir = self["gendir"]
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
    plugin_binary = self.get(key + "_plugin", plugin.executable)
    location = None

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
    self["cmd"] += ["--proto_path" + i for i in self["imports"]]
    self["cmd"] += self["args"]
    self["cmd"] += ["$(location " + proto + ")" for proto in self["protos"]]


def build_tools(lang, self):
    """Build a list of tools required for genrule execution"""

    self["tools"] += [self["protoc"]]

    protobuf_plugin = self["protobuf_plugin"]
    if not protobuf_plugin:
        if hasattr(lang, "protobuf") and hasattr(lang.protobuf, "executable"):
            protobuf_plugin = lang.protobuf.executable

    if protobuf_plugin:
        self["tools"] += [protobuf_plugin]

    grpc_plugin = self["grpc_plugin"]
    if self["with_grpc"] and not grpc_plugin:
        if hasattr(lang, "grpc") and hasattr(lang.grpc, "executable"):
            grpc_plugin = lang.grpc.executable

    if grpc_plugin:
        self["tools"] += [grpc_plugin]

    #print("tools: %s" % self["tools"])


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

    build_generated_filenames = build_generated_filenames,
    build_imports = build_imports,
    build_tools = build_tools,
    build_protobuf_invocation = build_protobuf_invocation,
    build_protobuf_out = build_protobuf_out,
    build_grpc_out = build_grpc_out,
    build_grpc_invocation = build_grpc_invocation,
    build_protoc_command = build_protoc_command,
    post_execute = post_execute,
)
