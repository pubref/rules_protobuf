load("//bzl:base/class.bzl", BASE = "CLASS", "build_plugin_out")
load("//bzl:util.bzl", "invoke", "invokesuper", "get_offset_path")


def build_generated_files(lang, self):
    """Build a jar file for protoc to dump java classes into."""
    ctx = self["ctx"]
    srcjar = ctx.outputs.srcjar
    basename = srcjar.basename[:-len(".srcjar")]
    protojar = ctx.new_file(srcjar, "%s.jar" % basename)
    execdir = self["execdir"]

    self["protojar"] = protojar
    self["outputs"] += [protojar]
    self["outdir"] = get_offset_path(execdir, protojar.path)


def build_grpc_out(lang, self):
    """Grpc out invocation is slightly different for java, looks like
       --grpc-java_out=%s rather than --grpc_out=%s
    """
    build_plugin_out("grpc-java", "grpc", lang, self)


def post_execute(lang, self):
    """Copy jar to srcjar so it can be consumed by java_library"""
    ctx = self["ctx"]
    srcjar = ctx.outputs.srcjar
    protojar = self["protojar"]

    # Note: in this case, don't have to specify offset_paths since we
    # already generated the files relative to the offset.

    ctx.action(
        mnemonic = "FixProtoSrcJar",
        inputs = [protojar],
        outputs = [srcjar],
        arguments = [protojar.path, srcjar.path],
        command = "cp $1 $2",
    )

    # Remove protojar from the list of provided outputs
    self["outputs"] = [e for e in self["outputs"] if e != protojar]
    self["outputs"] += [srcjar]

    if ctx.attr.verbose > 2:
        print("Copied jar %s srcjar to %s" % (protojar.path, srcjar.path))


def get_primary_output_suffix(lang, self):
    """The name of the implicit target that names the generated pb source files."""
    return ".pb.srcjar"


CLASS = struct(
    parent = BASE,
    name = "java",

    protobuf = struct(
        file_extensions = [".java"],
        compile_deps = [
            "@com_google_guava_guava//jar",
            "@com_google_protobuf_protobuf_java//jar",
        ],
        requires = [
            "com_google_protobuf_protobuf_java",
            "com_google_code_gson_gson",
            "com_google_guava_guava",
            "junit_junit_4", # TODO: separate test requirements
        ],
        outputs = {
            "srcjar": "%{name}.srcjar",
        }
    ),

    grpc = struct(
        name = "protoc-gen-grpc-java",
        executable = "//third_party/protoc_gen_grpc_java:protoc_gen_grpc_java_bin",
        requires = [
            "protoc_gen_grpc_java_linux_x86_64",
            "protoc_gen_grpc_java_macosx",
            "com_squareup_okhttp_okhttp",
            "com_squareup_okio_okio",
            "io_grpc_grpc_auth",
            "io_grpc_grpc_core",
            "io_grpc_grpc_netty",
            "io_grpc_grpc_okhttp",
            "io_grpc_grpc_protobuf",
            "io_grpc_grpc_protobuf_lite",
            "io_grpc_grpc_stub",
            "io_netty_netty_buffer",
            "io_netty_netty_codec",
            "io_netty_netty_codec_http",
            "io_netty_netty_codec_http2",
            "io_netty_netty_common",
            "io_netty_netty_handler",
            "io_netty_netty_resolver",
            "io_netty_netty_transport",
            "com_google_protobuf_protobuf_java_util",
            "com_google_auth_google_auth_library_credentials",
            "com_google_code_findbugs_jsr305",
        ],
        compile_deps = [
            "@com_google_guava_guava//jar",
            "@com_google_protobuf_protobuf_java//jar",
            "@io_grpc_grpc_core//jar",
            "@io_grpc_grpc_protobuf//jar",
            "@io_grpc_grpc_stub//jar",
        ],
        netty_runtime_deps = [
            "@io_grpc_grpc_netty//jar",
            "@io_grpc_grpc_protobuf_lite//jar",
            "@io_netty_netty_buffer//jar",
            "@io_netty_netty_codec//jar",
            "@io_netty_netty_codec_http2//jar",
            "@io_netty_netty_common//jar",
            "@io_netty_netty_handler//jar",
            "@io_netty_netty_resolver//jar",
            "@io_netty_netty_transport//jar",
        ],
    ),

    build_generated_files = build_generated_files,
    build_grpc_out = build_grpc_out,
    get_primary_output_suffix = get_primary_output_suffix,
    library = native.java_library,
    post_execute = post_execute,
)
