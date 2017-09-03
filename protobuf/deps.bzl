DEPS = {

    # Protobuf required for multiple reasons, including the cc_binary
    # 'protoc' and the cc_library 'protobuf_clib'
    # Building grpc requires it to be called thusly.
    "com_google_protobuf": {
        "rule": "http_archive",
        "url": "https://github.com/google/protobuf/archive/80a37e0782d2d702d52234b62dd4b9ec74fd2c95.zip", # 3.4.0
        "strip_prefix": "protobuf-80a37e0782d2d702d52234b62dd4b9ec74fd2c95",
        "sha256": "0b2e13f4c9e333d73e5cbc23c43ee87ce877f6c6adb6974aa526d5014318e4f7",
    },

    # This binds the cc_binary "protoc" into
    # //external:protoc. Required by grpc++.
    "protoc": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protoc",
    },

}
