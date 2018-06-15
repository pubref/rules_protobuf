CARES_VERSION = "3be1924221e1326df520f8498d704a5c4c8d0cce" # Jun 16, 2017 (1.13.0)

DEPS = {

    "com_google_grpc": {
        "rule": "grpc_archive",
        "url": "https://github.com/grpc/grpc/archive/66b9770a8ad326c1ee0dbedc5a8f32a52a604567.tar.gz", # 1.10.1
        "sha256": "14c1d63217f829f3c23bf039a76c186d0886c5b5c64e7eced44764f0fc564e6a",
        "strip_prefix": "grpc-66b9770a8ad326c1ee0dbedc5a8f32a52a604567",
    },

    "boringssl": {
        "rule": "http_archive",
        # master-with-bazel Fri Sep 01 15:09:13 2017 +0000
        "url": "https://boringssl.googlesource.com/boringssl/+archive/886e7d75368e3f4fab3f4d0d3584e4abfc557755.tar.gz",
    },

    # libssl is required for c++ grpc where it is expected in
    # //external:libssl.  This can be either boringssl or openssl.
    "libssl": {
        "rule": "bind",
        "actual": "@boringssl//:ssl",
    },

    # C-library for zlib
    "com_github_madler_zlib": {
        "rule": "new_http_archive",
        "url": "https://github.com/madler/zlib/archive/cacf7f1d4e3d44d871b605da3b647f07d718623f.zip", #v1.2.11
        "sha256": "1cce3828ec2ba80ff8a4cac0ab5aa03756026517154c4b450e617ede751d41bd",
        "strip_prefix": "zlib-cacf7f1d4e3d44d871b605da3b647f07d718623f",
        "build_file": str(Label("//protobuf:build_file/com_github_madler_zlib.BUILD")),
    },

    "com_github_cares_cares": {
        "rule": "new_http_archive",
        "url": "https://github.com/c-ares/c-ares/archive/%s.zip" % CARES_VERSION,
        "sha256": "932bf7e593d4683fce44fd26920f27d4f0c229113338e4f6d351e35d4d7c7a39",
        "strip_prefix": "c-ares-" + CARES_VERSION,
        "build_file": str(Label("//protobuf:build_file/cares.BUILD")),
    },
    
    # grpc++ expects //external:cares
    "cares": {
        "rule": "bind",
        "actual": "@com_github_cares_cares//:ares",
    },

    
    # grpc++ expects //external:zlib
    "zlib": {
        "rule": "bind",
        "actual": "@com_github_madler_zlib//:zlib",
    },

    # grpc++ expects //external:nanopb
    "nanopb": {
        "rule": "bind",
        "actual": "@com_google_grpc//third_party/nanopb",
    },

    # Bind the executable cc_binary grpc plugin into
    # //external:protoc_gen_grpc_cpp.  Expects
    # //external:protobuf_compiler. TODO: is it really necessary to
    # bind it in external?
    "protoc_gen_grpc_cpp": {
        "rule": "bind",
        "actual": "@com_google_grpc//:grpc_cpp_plugin",
    },

    # GTest is for our own internal cc tests.
    "com_google_googletest": {
        "rule": "http_archive",
        "url": "https://github.com/google/googletest/archive/7c6353d29a147cad1c904bf2957fd4ca2befe135.zip", # master Sept 1 2017
        "sha256": "f87029f647276734ef076785f76652347993b6d13ac1cbb2d2e976e16d2f8137",
        "strip_prefix": "googletest-7c6353d29a147cad1c904bf2957fd4ca2befe135",
    },

}
