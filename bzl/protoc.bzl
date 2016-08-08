load("//bzl:invoke.bzl", "invoke")

EXECUTABLE = Label("@com_github_google_protobuf//:protoc")

def protoc(lang,
           name,
           protos = [],
           protoc_executable=EXECUTABLE,
           protobuf_plugin_executable=None,
           protobuf_plugin_options=[],
           grpc_plugin_executable=None,
           grpc_plugin_options=[],
           imports = [],
           args = [],
           testonly = False,
           visibility = None,
           with_grpc = False,
           verbose = False,
           descriptor_set = None):

  if protoc_executable == None:
    protoc_executable = EXECUTABLE

  self = {
    "name": name,
    "protos": protos,
    "protoc": protoc_executable,
    "protobuf_plugin": protobuf_plugin_executable,
    "protobuf_plugin_options": protobuf_plugin_options,
    "grpc_plugin": grpc_plugin_executable,
    "grpc_plugin_options": grpc_plugin_options,
    "imports": imports,
    "testonly": testonly,
    "visibility": visibility,
    "args": args,
    "with_grpc": with_grpc,
    "descriptor_set": descriptor_set,
    "tools": [],
    "cmd": [],
    "outs": [],
    "verbose": verbose,
  }

  invoke("build_generated_files", lang, self)
  invoke("build_tools", lang, self)
  invoke("build_imports", lang, self)
  invoke("build_protoc_out", lang, self)
  invoke("build_protobuf_invocation", lang, self)
  invoke("build_protoc_arguments", lang, self)

  if self["with_grpc"]:
    if not hasattr(lang, "grpc"):
      fail("Language %s does not support gRPC" % lang.name)
    invoke("build_grpc_out", lang, self)
    invoke("build_grpc_invocation", lang, self)

  invoke("build_protoc_command", lang, self)
  invoke("execute_protoc_command", lang, self)

  self["hdrs"] = [src for src in self["outs"]]

  return struct(**self)
