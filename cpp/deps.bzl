DEPS = {

    # Grpc repo is required by multiple languages but we put it here.
    # This is the source or "base" archive for the 'grpc_repository'
    # rule, were we'll reconstruct a new repo by symlinking resources
    # from here into 'com_google_grpc'.
    "com_google_grpc_base": {
        "rule": "http_archive",
        "url": "https://github.com/grpc/grpc/archive/ca87867579580928ca4c9fdf97051fa25bf1d386.zip", # Sep 19, 2017 (PR#12571)
        "sha256": "d3794ca4ff7b12635bd4972bb9478f1d11e478305490b96469eb3a47e50b1768",
        "strip_prefix": "grpc-ca87867579580928ca4c9fdf97051fa25bf1d386",
    },

    "com_google_grpc": {
        "rule": "grpc_repository",
        "base_workspace": "@com_google_grpc_base//:WORKSPACE",
    },

    "com_github_c_ares_c_ares": {
        "rule": "new_http_archive",
        "url": "https://github.com/c-ares/c-ares/archive/7691f773af79bf75a62d1863fd0f13ebf9dc51b1.zip",
        "sha256": "ddce8def076a0a8cfa3f56595e391cf9e13a39fd4a7882822ed98cafd4079862",
        "strip_prefix": "c-ares-7691f773af79bf75a62d1863fd0f13ebf9dc51b1",
        "build_file_content": "",
    },

    "com_github_grpc_grpc": {
        "rule": "grpc_repository",
    },

    # Hooray! The boringssl team provides "master-with-bazel" and
    # "chromium-stable-with-bazel" branches with the BUILD files ready
    # to go.  To update, pick the newest-ish commit-id off that
    # branch.
    "boringssl": {
        "rule": "http_archive",
        # master-with-bazel Fri Sep 01 15:09:13 2017 +0000
        "url": "https://boringssl.googlesource.com/boringssl/+archive/74ffd81aa7ec3d0aa3d3d820dbeda934958ca81a.tar.gz",
        # Shockingly, tar.gz from googlesource has a different sha256 each time.  WTF?
        #"sha256": "7deda1bac8f10be6dca78b54b8b2886a215f6c62270afdd2ed43bc10920925c7",
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

    # grpc++ expects //external:cares
    "cares": {
        "rule": "bind",
        "actual": "@com_google_grpc//third_party/cares:ares",
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
