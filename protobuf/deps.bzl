DEPS = {

    # Protobuf required for multiple reasons, including the cc_binary
    # 'protoc' and the cc_library 'protobuf_clib'
    "com_google_protobuf": {
        "rule": "http_archive",
        # This is the commit grpc uses for their protobuf submodule
        "url": "https://github.com/google/protobuf/archive/b50c9ec1223895973d0e2fa6b6cb74ec3c8f3ce8.zip",
        "strip_prefix": "protobuf-b50c9ec1223895973d0e2fa6b6cb74ec3c8f3ce8",
        "sha256": "253f04f19074beb8d796d5582bab98126ea43cbfd2ff798d8bcc926f372ca523",
    },

    "com_google_protobuf_3.2.1": {
        "rule": "http_archive",
        # This is the commit grpc uses for their protobuf submodule
        "url": "https://github.com/google/protobuf/archive/593e917c176b5bc5aafa57bf9f6030d749d91cd5.zip",
        "strip_prefix": "protobuf-593e917c176b5bc5aafa57bf9f6030d749d91cd5",
        "sha256": "73719860b639b79f84a3563c82815884ff74f1cd001900080e1b598d2594d450",
    },



    # This binds the cc_binary "protoc" into
    # //external:protoc. Required by grpc++.
    "protoc": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protoc",
    },

}
