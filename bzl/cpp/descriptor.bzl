DESCRIPTOR = struct(
    name = "cpp",
    short_name = "cpp",
    pb_file_extensions = [".pb.h", ".pb.cc"],
    supports_grpc = True,
    plugin_default_options = [],
    requires = [
        "grpc",
        "zlib",
        "external_zlib",
        "nanopb",
        "external_nanopb",
        "boringssl",
        "libssl",
        "protobuf",
        "external_protobuf_clib",
        "external_protobuf_compiler",
    ]
)
