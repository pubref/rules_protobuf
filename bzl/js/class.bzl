load("//bzl:base/class.bzl", BASE = "CLASS", "build_plugin_out")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:util.bzl", "invokesuper", "get_offset_path")

# https://github.com/bazelbuild/bazel/blame/master/src/main/java/com/google/devtools/build/lib/packages/BuildType.java#L227
# NPE at BuildType.java:227 when str() is used to wrap Label i.e. attr.label_list(default = [str(Label("...")])


def js_library(**kwargs):
    """Dummy implementation."""
    pass


def implement_compile_attributes(lang, self):
    """Override attributes"""
    GO.implement_compile_attributes(lang, self)

    attrs = self["attrs"]
    attrs["library"] = attr.string()

    attrs["binary"] = attr.bool(
        default = True,
    )
    attrs["namespace_prefix"] = attr.string()
    attrs["add_require_for_enums"] = attr.bool()
    attrs["error_on_name_conflict"] = attr.bool(
        default = True,
    )
    attrs["import_style"] = attr.string(
        default = "closure", # commonjs|browser|es6,
    )


def build_protobuf_out(lang, self):
    ctx = self["ctx"]
    import_style = ctx.attr.import_style
    optskey = "_".join(["gen", lang.name, "protobuf", "options"])
    opts = getattr(ctx.attr, optskey, [])
    opts += self.get(optskey, [])
    opts += ["import_style=" + import_style]

    prop = "pbjs" if import_style == "commonjs" else "js"
    ext = ".pb" + ("_pb.js" if import_style == "commonjs" else ".js")

    outfile = getattr(ctx.outputs, prop)
    print("outfile: %s" % outfile.path)
    libname = outfile.basename[:-len(ext)]
    print("ext: %s" % ext)
    print("libname: %s" % libname)
    opts += ["library=%s" % libname]

    self["libname"] = libname

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


def build_generated_files(lang, self):
    ctx = self["ctx"]
    import_style = ctx.attr.import_style
    #prop = "pbjs" if import_style == "commonjs" else "js"
    ext = ".pb" + ("_pb.js" if import_style == "commonjs" else ".js")
    outfile = ctx.new_file(libname + ext)

    outfile = getattr(ctx.outputs, prop)
    libfile = ctx.new_file("foo.js")
    print("predicted outfile: %s" % outfile.path)
    self["outputs"] += [outfile]
    #self["outdir"] = get_offset_path(self["execdir"], outfile.path)


def post_execute(lang, self):
    ctx = self["ctx"]

    # We don't know until runtime which one is the primary source, but
    # we had to declare at compile time that both would be generated.
    # So, copy over whichever one was not created yet.

    src = "pbjs" if ctx.attr.import_style == 'commonjs' else 'js'
    dst = "js" if ctx.attr.import_style == 'commonjs' else 'pbjs'
    srcfile = getattr(ctx.outputs, src)
    dstfile = getattr(ctx.outputs, dst)

    ctx.action(
        mnemonic = "CoverAllBasesWithJsOutputs",
        inputs = [srcfile],
        outputs = [dstfile],
        arguments = [srcfile.path, dstfile.path],
        command = "cp $1 $2",
    )

    if ctx.attr.verbose > 2:
        print("Copied %s --> %s" % (srcfile.basename, dstfile.basename))

    self["outputs"] += [dstfile]

CLASS = struct(
    parent = BASE,
    name = "js",

    protobuf = struct(
        # File extension is dependent on the import_style, to don't specify it here.
        #file_extensions = ["_pb.js"],
        compile_deps = [],
    ),

    build_protobuf_out = build_protobuf_out,
    build_generated_files = build_generated_files,
    implement_compile_attributes = implement_compile_attributes,
    library = js_library,
    post_execute = post_execute,
)
