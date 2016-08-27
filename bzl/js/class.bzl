load("//bzl:base/class.bzl", BASE = "CLASS", "build_plugin_out")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:util.bzl", "invokesuper", "get_offset_path")

# https://github.com/bazelbuild/bazel/blame/master/src/main/java/com/google/devtools/build/lib/packages/BuildType.java#L227
# NPE at BuildType.java:227 when str() is used to wrap Label i.e. attr.label_list(default = [str(Label("...")])

IMPORT_STYLES = [
    "closure",
    "commonjs",
    "browser",
    "es6",
]

def js_library(**kwargs):
    """Dummy implementation."""
    pass


def implement_compile_attributes(lang, self):
    """Override attributes"""
    GO.implement_compile_attributes(lang, self)

    attrs = self["attrs"]

    # The name of the output library to generate.  This affects the
    # name of the output file.w
    attrs["library"] = attr.string()

    # Should the generated files support binary content?
    attrs["binary"] = attr.bool(
        default = True,
    )

    # Listed on the js struct.
    attrs["namespace_prefix"] = attr.string()

    # Listed on the js struct.
    attrs["add_require_for_enums"] = attr.bool()

    # Should output filename collision cause error?  Yes, it should.
    attrs["error_on_name_conflict"] = attr.bool(
        default = True,
    )

    # Enum of allowed import styles.
    attrs["import_style"] = attr.string(
        default = "closure", # commonjs|browser|es6,
    )


def build_generated_files(lang, self):
    ctx = self["ctx"]
    import_style = ctx.attr.import_style

    # Argument to the 'library' option will be the label NAME unless
    # it has the form 'NAME.pb' that by convention is used by the
    # proto_library rules.
    libname = ctx.label.name
    if libname.endswith(".pb"):
        libname = libname[:-len(".pb")]

    print("import style %s" % import_style)
    # Stupid special case: choose appropriate extension based on the
    # import style.
    ext = ".pb.js" if import_style == "commonjs" else ".js"

    # Create a file and add it to the list of outputs.
    outfile = ctx.new_file(libname + ext)

    self["outputs"] += [outfile]

    # Store that for later reference
    self["outfile"] = outfile
    self["libname"] = libname


def build_protobuf_out(lang, self):
    ctx = self["ctx"]
    import_style = ctx.attr.import_style
    if not import_style in IMPORT_STYLES:
        fail("%s is not a valid option: must be one of %s" % (import_style, IMPORT_STYLES))

    optskey = "_".join(["gen", lang.name, "protobuf", "options"])
    libname = self["libname"]
    outfile = self["outfile"]
    parts = outfile.short_path.rpartition("/")
    filename = "/".join([parts[0], libname])
    library_path = get_offset_path(self["execdir"], filename)

    opts = getattr(ctx.attr, optskey, [])
    opts += self.get(optskey, [])
    opts += ["import_style=%s" % import_style]
    opts += ["library=%s" % library_path]

    if ctx.attr.binary:
        opts += ["binary"]
    if ctx.attr.testonly:
        opts += ["testonly"]
    if ctx.attr.add_require_for_enums:
        opts += ["add_require_for_enums"]
    if ctx.attr.error_on_name_conflict:
        opts += ["error_on_name_conflict"]

    self[optskey] = opts
    invokesuper("build_protobuf_out", lang, self)



CLASS = struct(
    parent = BASE,
    name = "js",

    protobuf = struct(
        # File extension is dependent on the import_style, to don't specify it here.
        #file_extensions = ["_pb.js", ".js"],
        compile_deps = [],
    ),

    build_protobuf_out = build_protobuf_out,
    build_generated_files = build_generated_files,
    implement_compile_attributes = implement_compile_attributes,
    library = js_library,
)
