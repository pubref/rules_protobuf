load("//bzl:base/class.bzl", BASE = "CLASS")
load("//bzl:util.bzl", "invokesuper")


def _build_protobuf_out(lang, self):
    """Override behavior to add a plugin option before building the --go_out option"""
    if self["with_grpc"]:
        self["protobuf_plugin_options"] += ["plugins=grpc"]
    invokesuper("build_protobuf_out", lang, self)


def _build_grpc_out(lang, self):
    """Override behavior to skip the --grpc_out option (protoc-gen-go does not use it)"""
    pass


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
            "@com_github_golang_glog//:go_default_library",
            "@org_golang_google_grpc//:go_default_library",
            "@org_golang_x_net//:context",
        ],
    ),

    build_protobuf_out = _build_protobuf_out,
    build_grpc_out = _build_grpc_out,
)
