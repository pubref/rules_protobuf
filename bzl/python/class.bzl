load("//bzl:base/class.bzl", BASE = "CLASS")


CLASS = struct(
    parent = BASE,
    name = "python",
    short_name = "py",
    protobuf = struct(
        file_extensions = ["_pb2.py"],
        compile_deps = [
        ],
    ),
)
