load("//bzl:base/class.bzl", BASE = "CLASS")

def ruby_library(**kwargs):
    """Dummy implementation."""
    pass


CLASS = struct(
    parent = BASE,
    name = "ruby",

    protobuf = struct(
        file_extensions = ["_pb.rb"],
        compile_deps = [],
    ),

    library = ruby_library,
)
