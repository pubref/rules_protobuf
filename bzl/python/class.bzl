load("//bzl:base/class.bzl", BASE = "CLASS")

CLASS = struct(
        parent = BASE,
        name = "python",

        protobuf = struct(
            file_extensions = ["_pb2.py"],
            compile_deps = [],
        ),

        library = native.py_library,
)
