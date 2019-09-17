
BAZEL_SKYLIB_VERSION = "6741f733227dc68137512161a5ce6fcf283e3f58"  # 0.7.0

DEPS = {

    "com_google_protobuf": {
        "rule": "http_archive",
        "url": "https://github.com/protocolbuffers/protobuf/archive/v3.7.1.zip",
        "strip_prefix": "protobuf-3.7.1",
        "sha256": "f976a4cd3f1699b6d20c1e944ca1de6754777918320c719742e1674fcf247b7e",
    },

    "bazel_skylib": {
        "rule": "http_archive",
        "strip_prefix": "bazel-skylib-%s" % BAZEL_SKYLIB_VERSION,
        "url": "https://github.com/bazelbuild/bazel-skylib/archive/%s.tar.gz" % BAZEL_SKYLIB_VERSION,
        "sha256": "c202e39b4125ca41d95ebe494ae6a7a3674772df0dc4b1a51e82cf0e55ba78ed",
    },

    # C-library for zlib
    "com_github_madler_zlib": {
        "rule": "http_archive",
        "url": "https://github.com/madler/zlib/archive/cacf7f1d4e3d44d871b605da3b647f07d718623f.zip", #v1.2.11
        "sha256": "1cce3828ec2ba80ff8a4cac0ab5aa03756026517154c4b450e617ede751d41bd",
        "strip_prefix": "zlib-cacf7f1d4e3d44d871b605da3b647f07d718623f",
        "build_file": str(Label("//protobuf:build_file/com_github_madler_zlib.BUILD")),
    },

    # grpc++ //external:zlib
    "zlib": {
        "rule": "bind",
        "actual": "@com_github_madler_zlib//:zlib",
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
