package(default_visibility = ["//visibility:public"])

cc_binary(
  name = "protoc_gen_python_grpc_bin",
  srcs = [
    "src/compiler/python_plugin.cc",
  ],
  deps = [
    "//third_party/protoc:protoc_bin",
    ":grpc_plugin_support",
  ],
)
