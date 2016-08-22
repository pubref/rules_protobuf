load("//bzl:base/class.bzl", BASE = "CLASS", "build_plugin_out")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:util.bzl", "invokesuper")


def build_protobuf_out(lang, self):
    """Build the --{lang}_out option"""
    build_plugin_out(lang.name, "protobuf", lang, self)


def build_imports(lang, self):
    invokesuper("build_imports", lang, self)
    self["imports"] += [
        "external/com_github_grpc_ecosystem_grpc_gateway/third_party/googleapis",
        "external/com_github_google_protobuf/src",
        ".",
    ]

def build_grpc_out(lang, self):
    opts = self.get("gateway_plugin_options", [])
    opts += ["logtostderr=true"]
    outdir = self["gendir"]
    if opts:
        outdir = ",".join(opts) + ":" + outdir
    self["args"] += ["--grpc-gateway_out=%s" % (outdir)]


CLASS = struct(
        parent = BASE,
        name = "go", # Left as "go" to implement gen_go and hence --protoc-gen-go=...
        short_name = "gateway",

        protobuf = struct(
            name = GO.protobuf.name,
            file_extensions = GO.protobuf.file_extensions,
            executable = GO.protobuf.executable,
            tools = [
                "@com_github_grpc_ecosystem_grpc_gateway//:googleapis",
            ],
            default_options = [
                "Mgoogle/api/annotations.proto=github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis/google/api",
            ],
            requires = GO.protobuf.requires,
            compile_deps = GO.protobuf.compile_deps,
        ),

        grpc = struct(
            name = 'protoc-gen-grpc-gateway',
            file_extensions = [".pb.gw.go"],
            executable = "@com_github_grpc_ecosystem_grpc_gateway//:protoc-gen-grpc-gateway_bin",
            default_options = GO.grpc.default_options,
            requires = GO.grpc.requires + [
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

        build_protobuf_out = GO.build_protobuf_out,
        build_grpc_out = build_grpc_out,
        build_imports = build_imports,
)
