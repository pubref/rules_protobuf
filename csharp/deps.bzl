PROTOBUF_BUILD_FILE = """
load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "dll_import")
dll_import(
  name = "libnet45",
  srcs = [
    "Google.Protobuf.3.2.0/lib/net45/Google.Protobuf.dll",
  ],
  visibility = ["//visibility:public"],
)
"""

GRPC_BUILD_FILE = """
load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "dll_import")
dll_import(
  name = "runtime_osx",
  srcs = glob(["Grpc.Core.1.2.2/runtimes/osx/**/*.dll"]),
  visibility = ["//visibility:public"],
)
dll_import(
  name = "system_interactive_async",
  srcs = glob(["System.Interactive.Async.3.0.0/lib/net45/**/*.dll"]),
  visibility = ["//visibility:public"],
)
dll_import(
  name = "core",
  srcs = glob(["Grpc.Core.1.2.2/lib/net45/**/*.dll"]),
  visibility = ["//visibility:public"],
)
"""

DEPS = {

    "nuget_google_protobuf": {
        "rule": "new_nuget_package",
        "package": "Google.Protobuf",
        "version": "3.2.0",
        "build_file_content": PROTOBUF_BUILD_FILE,
    },

    "nuget_grpc": {
        "rule": "new_nuget_package",
        "package": "Grpc",
        "version": "1.2.2",
        "build_file_content": GRPC_BUILD_FILE,
    },

    "protoc_gen_grpc_csharp": {
        "rule": "bind",
        "actual": "@com_google_grpc//:grpc_csharp_plugin",
    },

}
