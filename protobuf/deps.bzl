DEPS = {

    # Protobuf required for multiple reasons, including the cc_binary
    # 'protoc' and the cc_library 'protobuf_clib'
    "com_github_google_protobuf": {
        "rule": "git_repository",
        "remote": "https://github.com/google/protobuf.git",
        "commit": "52ab3b07ac9a6889ed0ac9bf21afd8dab8ef0014", # Oct 4, 2016
        #"branch": "v3.1.x",
    },

    # This binds the cc_binary "protoc" into
    # //external:protoc. Required by grpc++.
    "protoc": {
        "rule": "bind",
        "actual": "@com_github_google_protobuf//:protoc",
    },

}
