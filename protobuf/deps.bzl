DEPS = {

    # Protobuf required for multiple reasons, including the cc_binary
    # 'protoc' and the cc_library 'protobuf_clib'
    "com_github_google_protobuf_OLD": {
        "rule": "git_repository",
        "remote": "https://github.com/google/protobuf.git",
        "commit": "52ab3b07ac9a6889ed0ac9bf21afd8dab8ef0014", # Oct 4, 2016
        #"branch": "v3.1.x",
    },

    # Protobuf required for multiple reasons, including the cc_binary
    # 'protoc' and the cc_library 'protobuf_clib'
    # This is the commit grpc uses for their protobuf submodule
    # "com_github_google_protobuf": {
    #     "rule": "http_archive",
    #     "url": "https://github.com/google/protobuf/archive/a6189acd18b00611c1dc7042299ad75486f08a1a.zip",
    #     "strip_prefix": "protobuf-a6189acd18b00611c1dc7042299ad75486f08a1a",
    #     "sha256": "102b5024120215c5a34ad23d9dd459e8ccc37dc3ef4c73d466ab802b6e3e9512",
    # },

    "com_github_google_protobuf": {
        "rule": "http_archive",
        "url": "https://github.com/google/protobuf/archive/80a37e0782d2d702d52234b62dd4b9ec74fd2c95.zip", # 3.4.0
        "strip_prefix": "protobuf-80a37e0782d2d702d52234b62dd4b9ec74fd2c95",
        "sha256": "0b2e13f4c9e333d73e5cbc23c43ee87ce877f6c6adb6974aa526d5014318e4f7",
    },

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
        "actual": "@com_github_google_protobuf//:protoc",
    },

}
