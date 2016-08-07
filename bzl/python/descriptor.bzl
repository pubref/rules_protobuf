DESCRIPTOR = struct(
    name = "python",
    short_name = "py",
    pb_file_extensions = ["_pb2.py"],
    supports_grpc = True,
    #plugin_exe = "//external:protoc-gen-grpc",
    plugin_name = 'ruby',
    plugin_default_options = [],
    requires = [
        "protobuf",
        "external_protoc",
        "grpc",
        "libssl",
        "zlib",
    ]
)
