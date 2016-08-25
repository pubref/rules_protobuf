load("//bzl:base/class.bzl", BASE = "CLASS", "build_plugin_out")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:util.bzl", "invokesuper")

# https://github.com/bazelbuild/bazel/blame/master/src/main/java/com/google/devtools/build/lib/packages/BuildType.java#L227
# NPE at BuildType.java:227 when str() is used to wrap Label i.e. attr.label_list(default = [str(Label("...")])

def implement_compile_attributes(lang, self):
    """Override attributes for the X_proto_compile rule"""
    GO.implement_compile_attributes(lang, self)

    attrs = self["attrs"]

    attrs["_googleapi_protos"] = attr.label(
        default = Label(
            "@com_github_grpc_ecosystem_grpc_gateway//:googleapi_protos",
        ),
    )

    attrs["logtostderr"] = attr.bool(default = True)
    attrs["alsologtostderr"] = attr.bool()
    attrs["stderrthreshold"] = attr.int()
    attrs["log_backtrace_at"] = attr.int()
    attrs["log_dir"] = attr.string()
    attrs["log_level"] = attr.int()
    # TODO:-vmodule value: what does this mean?

    attrs["import_prefix"] = attr.string()
    attrs["gateway_imports"] = attr.string_list(
        default = lang.default_imports
    )


def build_imports(lang, self):
    invokesuper("build_imports", lang, self)
    ctx = self["ctx"]
    self["imports"] += ctx.attr.gateway_imports


def build_inputs(lang, self):
    invokesuper("build_inputs", lang, self)
    ctx = self["ctx"]
    self["inputs"] += list(ctx.attr._googleapi_protos.files)


def build_protobuf_out(lang, self):
    # Protobuf outputs are implemented by the GO.class, so there is no
    # additional work to be done here.
    pass


def build_grpc_out(lang, self):
    ctx = self["ctx"]
    optskey = "_".join(["gen", lang.name, "grpc", "options"])
    opts = getattr(ctx.attr, optskey, [])
    opts += self.get(optskey, [])

    if ctx.attr.logtostderr:
        opts += ["logtostderr=true"]
    if ctx.attr.alsologtostderr:
        opts += ["alsologtostderr=true"]
    if ctx.attr.log_backtrace_at:
        opts += ["log_backtrace_at=%s" % ctx.attr.log_backtrace_at]
    if ctx.attr.stderrthreshold:
        opts += ["stderrthreshold=%s" % ctx.attr.stderrthreshold]
    if ctx.attr.log_dir:
        opts += ["log_dir=%s" % ctx.attr.log_dir]
    if ctx.attr.log_level:
        opts += ["v=%s" % ctx.attr.log_level]
    if ctx.attr.import_prefix:
        opts += ["import_prefix=%s" % ctx.attr.import_prefix]

    params = ",".join(opts) + ":" + self["outdir"]

    self["args"] += ["--grpc-gateway_out=%s" % params]


CLASS = struct(
    parent = BASE,
    name = "gateway",

    default_go_import_map = {
        "google/api/annotations.proto": "github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis/google/api"
    },

    default_imports = [
        "external/com_github_grpc_ecosystem_grpc_gateway/third_party/googleapis/",
        "external/com_github_google_protobuf/src/",
    ],

    grpc = struct(
        name = 'protoc-gen-grpc-gateway',
        file_extensions = [".pb.gw.go"],
        executable = "@com_github_grpc_ecosystem_grpc_gateway//:protoc-gen-grpc-gateway_bin",
        default_options = GO.grpc.default_options,
        requires = [
            "com_github_grpc_ecosystem_grpc_gateway",
        ],
        compile_deps = GO.grpc.compile_deps + [
            "@com_github_grpc_ecosystem_grpc_gateway//:runtime",
            "@com_github_grpc_ecosystem_grpc_gateway//:utilities",
            "@com_github_grpc_ecosystem_grpc_gateway//:third_party/googleapis/google/api",
            "@org_golang_google_grpc//:codes",
            "@org_golang_google_grpc//:grpclog",
        ],
    ),

    implement_compile_attributes = implement_compile_attributes,
    build_protobuf_out = build_protobuf_out,
    build_grpc_out = build_grpc_out,
    build_imports = build_imports,
    build_inputs = build_inputs,
    library = GO.library,
)
