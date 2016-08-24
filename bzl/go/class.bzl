load("//bzl:base/class.bzl", BASE = "CLASS")
load("//bzl:util.bzl", "invokesuper")


def _build_protobuf_out(lang, self):
    """Override behavior to add a plugin option before building the --go_out option"""
    if self.get("with_grpc", False):
        self["protobuf_plugin_options"] = self.get("protobuf_plugin_options", []) + ["plugins=grpc"]
    invokesuper("build_protobuf_out", lang, self)


def _build_grpc_out(lang, self):
    """Override behavior to skip the --grpc_out option (protoc-gen-go does not use it)"""
    pass


def _build_imports(lang, self):
    """@Override: Copy any named proto files in the imports to the genfiles area to make visible to protoc.  Not sure this is necessary anymore."""
    invokesuper("build_imports", lang, self)

    ctx = self["ctx"]
    if not ctx:
        fail("Bazel context is required for build_imports")

    go_prefix = ctx.attr.go_prefix.go_prefix

    for dep in ctx.attr.deps:
        provider = dep.proto
        #print("proto provider: %s" % dir(provider))
        proto_packages = provider.transitive_packages
        #print("proto_packages: %s" % proto_packages)
        for pkg, srcs in proto_packages.items():
            target = pkg.rsplit(':') # [0] == ctx.label.package, [1] == ctx.label.name
            #print("target: %s" % target)
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

    build_protobuf_out = _build_protobuf_out,
    build_grpc_out = _build_grpc_out,
    build_imports = _build_imports,
)
