package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # AS-IS

cc_binary(
    name = "protoc_gen_python_grpc_bin",
    srcs = [
        "src/compiler/python_plugin.cc",
    ],
    deps = [
        ":grpc_plugin_support",
        "//third_party/protoc:protoc_bin",
    ],
)
