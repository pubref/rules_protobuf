load("//bzl:base/class.bzl", BASE = "CLASS")

def csharp_library(**kwargs):
    """Dummy implementation."""
    pass


CLASS = struct(
    parent = BASE,
    name = "csharp",

    protobuf = struct(
        file_extensions = ["_pb.rb"],
        compile_deps = [],
    ),

    library = csharp_library,
)
