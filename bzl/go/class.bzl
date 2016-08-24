load("//bzl:base/class.bzl", BASE = "CLASS")
load("//bzl:util.bzl", "invokesuper")


def implement_compile_attributes(lang, self):
    """Override attributes for the X_proto_compile rule"""
    invokesuper("implement_compile_attributes", lang, self)

    attrs = self["attrs"]

    # go_prefix is necessary for protoc-gen-go import mapping of dependent protos.
    attrs["go_prefix"] = attr.label(
        providers = ["go_prefix"],
        default = Label(
            "//:go_prefix",
            relative_to_caller_repository = True,
        ),
        allow_files = False,
        cfg = HOST_CFG,
    )

    attrs["go_import_map"] = attr.string_dict()


def build_protobuf_out(lang, self):
    """Override behavior to add a plugin option before building the --go_out option"""
    if self.get("with_grpc", False):
        self["protobuf_plugin_options"] = self.get("protobuf_plugin_options", []) + ["plugins=grpc"]

    ctx = self["ctx"]
    if ctx.attr.verbose > 1:
        print("go_import_map: %s" % ctx.attr.go_import_map)
    for k, v in ctx.attr.go_import_map.items():
        self["protobuf_plugin_options"] += ["M%s=%s" % (k, v)]

    invokesuper("build_protobuf_out", lang, self)


def build_grpc_out(lang, self):
    """Override behavior to skip the --grpc_out option (protoc-gen-go does not use it)"""
    pass


def build_imports(lang, self):
    """@Override: for all transitive packages source file names, provide import mapping."""
    invokesuper("build_imports", lang, self)

    ctx = self["ctx"]

    go_prefix = ctx.attr.go_prefix.go_prefix

    for dep in ctx.attr.deps:
        provider = dep.proto
        proto_packages = provider.transitive_packages
        for pkg, srcs in proto_packages.items():
            target = pkg.rsplit(':') # [0] == ctx.label.package, [1] == ctx.label.name
            for srcfile in srcs:
                src = srcfile.short_path
                dst = go_prefix + '/' + target[0]
                if target[1] != "go_default_library.pb":
                    # slice off the '.pb' from 'mylib.protos'
                    dst += "/" + target[1][:-len(".pb")]
                self["protobuf_plugin_options"] = self.get("protobuf_plugin_options", []) + ["M%s=%s" % (src, dst)]


CLASS = struct(
    parent = BASE,
    name = "go",
    short_name = "go",

    protobuf = struct(
        name = 'protoc-gen-go',
        file_extensions = [".pb.go"],
        executable = "@com_github_golang_protobuf//:protoc_gen_go",
        default_options = [],
        requires = [
            "com_github_golang_protobuf",
        ],
        compile_deps = [
            "@com_github_golang_protobuf//:proto",
        ],
    ),

    grpc = struct(
        name = 'grpc',
        default_options = [],
        requires = [
            "com_github_golang_glog",
            "org_golang_google_grpc",
            "org_golang_x_net",
        ],
        compile_deps = [
            "@com_github_golang_protobuf//:proto",
            "@com_github_golang_glog//:go_default_library",
            "@org_golang_google_grpc//:go_default_library",
            "@org_golang_x_net//:context",
        ],
    ),

    build_protobuf_out = build_protobuf_out,
    build_grpc_out = build_grpc_out,
    build_imports = build_imports,
    implement_compile_attributes = implement_compile_attributes,
)
