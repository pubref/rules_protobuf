load("//bzl:base/class.bzl", BASE = "CLASS", "build_plugin_out")
load("//bzl:util.bzl", "invokesuper")


def _build_grpc_out(lang, self):
    """Grpc out invocation is slightly different for java, looks like
       --grpc-java_out=%s rather than --grpc_out=%s
    """
    build_plugin_out("grpc-java", "grpc", lang, self)


def _build_source_files(lang, self):
    """Build a jar file for protoc to dump java classes into."""
    invokesuper("build_source_files", lang, self)

    ctx = self.get("ctx", None)
    if ctx == None:
        fail("Java implementation requires bazel context")

    srcjar = ctx.outputs.srcjar
    basename = srcjar.basename[:-len(".srcjar")]
    protojar = ctx.new_file(srcjar, "%s.jar" % basename)
    self["protojar"] = protojar
    # This will generate the jar inthe source tree itself
    #self["gendir"] = protojar.short_path

    # This will generate the jar in the BINDIR
    self["gendir"] = protojar.path
    self["provides"] += [protojar]


def _post_execute(lang, self):
    """Copy jar to srcjar"""

    ctx = self.get("ctx", None)
    srcjar = ctx.outputs.srcjar
    protojar = self["protojar"]

    # Rename protojar to srcjar so that rules like java_library can
    # consume it.
    ctx.action(
        mnemonic = "FixProtoSrcJar",
        inputs = [protojar],
        outputs = [srcjar],
        arguments = [protojar.path, srcjar.path],
        command = "cp $1 $2",
    )

    # Remove protojar from the list of provided outputs
    self["provides"] = [e for e in self["provides"] if e != protojar]
    self["provides"] += [srcjar]

    if self["verbose"]:
        print("Copied jar %s srcjar to %s" % (protojar.path, srcjar.path))


CLASS = struct(
        parent = BASE,
        name = "java",
        short_name = "java",

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
            executable = "//third_party/protoc_gen_grpc_java:protoc_gen_grpc_java_bin",
            name = "protoc-gen-grpc-java",
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
                "io_grpc_grpc_protobuf_nano",
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
                "com_google_protobuf_nano_protobuf_javanano",
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

        build_source_files = _build_source_files,
        build_grpc_out = _build_grpc_out,
        post_execute = _post_execute,
)
