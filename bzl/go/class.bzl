load("@io_bazel_rules_go//go:def.bzl", "go_library")
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
    """Override behavior to add plugin options before building the --go_out option"""
    ctx = self["ctx"]
    go_prefix = ctx.attr.go_prefix.go_prefix
    optskey = "gen_" + lang.name + "_protobuf_options"
    opts = self.get(optskey, [])

    # Add in the 'plugins=grpc' option to the protoc-gen-go plugin if
    # the user wants grpc.
    if self["with_grpc"] or getattr(ctx.attr, "gen_" + lang.name + "_grpc", False):
        opts += ["plugins=grpc"]

    # Build the list of import mappings.  Start with any configured on
    # the rule by attributes.
    mappings = {} + ctx.attr.go_import_map

    # Then add in the transitive set from dependent rules.
    for dep in ctx.attr.proto_deps:
        provider = dep.proto
        packages = provider.transitive_packages
        for pkg, protos in packages.items():
            target = pkg.rsplit(':') # [0] == ctx.label.package, [1] == ctx.label.name
            for file in protos:
                src = file.short_path
                dst = go_prefix + '/' + target[0] # (A) / (B)
                # the name of the calling rule is not
                # 'go_default_library', add that last part (C) in.
                if target[1] != "go_default_library.pb":
                    # slice off the '.pb' from 'mylib.protos'
                    dst += "/" + target[1][:-len(".pb")]
                mappings[src] = dst

    if ctx.attr.verbose > 1:
        print("go_import_map: %s" % mappings)

    for k, v in mappings.items():
        opts += ["M%s=%s" % (k, v)]

    self[optskey] = opts
    invokesuper("build_protobuf_out", lang, self)


def build_grpc_out(lang, self):
    """Override behavior to skip the --grpc_out option (protoc-gen-go does not use it)"""
    pass


CLASS = struct(
    parent = BASE,
    name = "go",

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

    build_grpc_out = build_grpc_out,
    build_protobuf_out = build_protobuf_out,
    implement_compile_attributes = implement_compile_attributes,
    library = go_library,
)
