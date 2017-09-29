DEPS = {

    # Protobuf required for multiple reasons, including the cc_binary
    # 'protoc' and the cc_library 'protobuf_clib'
    # Building grpc requires it to be called thusly.
    "com_google_protobuf": {
        "rule": "http_archive",
        "url": "https://github.com/google/protobuf/archive/v3.4.0.zip",
        "strip_prefix": "protobuf-3.4.0",
        "sha256": "542703acadc3f690d998f4641e1b988f15ba57ebca05fdfb1cd9095bec007948",
    },

    # This binds the cc_binary "protoc" into
    # //external:protoc. Required by grpc++.
    "protoc": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protoc",
    },

    # Bind the protobuf proto_lib into //external.  Required for
    # compiling the protoc_gen_grpc plugin
    "protocol_compiler": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protoc",
    },

    # grpc++ expects "//external:protobuf"
    "protobuf": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protobuf",
    },

    # grpc++ expects "//external:protobuf_clib"
    "protobuf_clib": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protoc_lib",
    },

}
