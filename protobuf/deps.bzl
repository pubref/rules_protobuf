
DEPS = {

    "com_google_protobuf": {
        "rule": "http_archive",
        "url": "https://github.com/protocolbuffers/protobuf/archive/v3.6.1.3.zip",
        "strip_prefix": "protobuf-3.6.1.3",
        "sha256": "9510dd2afc29e7245e9e884336f848c8a6600a14ae726adb6befdb4f786f0be2",
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

    "protobuf_headers": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protobuf_headers",
    },

}
