load("//bzl:base/descriptor.bzl", BASE = "DESCRIPTOR")
load("//bzl:invoke.bzl", "invoke", "invokesuper")

DESCRIPTOR = struct(
    parent = BASE,
    name = "python",
    short_name = "py",
    protobuf = struct(
        file_extensions = ["_pb2.py"],
        compile_deps = [
        ],
    ),
)
