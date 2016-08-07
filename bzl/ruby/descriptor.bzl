DESCRIPTOR = struct(
    name = "ruby",
    short_name = "ruby",
    pb_file_extensions = ["_pb.rb"],
    supports_grpc = True,
    #plugin_exe = "//external:protoc-gen-grpc",
    plugin_name = 'ruby',
    plugin_default_options = [],
    requires = [
        "protobuf",
    ]
)
