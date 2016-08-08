load("@io_bazel_rules_go//go:def.bzl", "go_library")


def _build_library(ctx, lang, compile_result):
    print("Compiling go library...")
    native.genrule(
    #go_library(
        srcs = compile_result.files + ctx.attr.go_srcs,
        deps = lang.compile_deps,
    )


DESCRIPTOR = struct(
    name = "go",
    short_name = "go",
    pb_file_extensions = [".pb.go"],
    supports_grpc = True,
    plugin_name = 'protoc-gen-go',
    plugin_default_options = [],
    plugin_executable = "@com_github_golang_protobuf//:protoc_gen_go",
    requires = [
        "com_github_golang_glog",
        "com_github_golang_protobuf",
        "org_golang_google_grpc",
        "org_golang_x_net",
    ],
    compile_deps = [
        "@com_github_golang_glog//:go_default_library",
        "@com_github_golang_protobuf//:proto",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//:context",
    ],
    #build_library = _build_library,
)
