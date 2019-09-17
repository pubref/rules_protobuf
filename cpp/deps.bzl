CARES_VERSION = "3be1924221e1326df520f8498d704a5c4c8d0cce" # Jun 16, 2017 (1.13.0)

DEPS = {

    "com_github_grpc_grpc": {
        "rule": "grpc_archive",
        "url": "https://github.com/grpc/grpc/archive/befc7220cadb963755de86763a04ab6f9dc14200.tar.gz", # 1.13.1
        "sha256": "24c9bc2bd60058154953de2eabc21791ad7de0dcb59c8216f1e1e76085eecfff",
        "strip_prefix": "grpc-befc7220cadb963755de86763a04ab6f9dc14200",
    },

    "boringssl": {
        "rule": "http_archive",
        # master-with-bazel Mon Sep 16 21:35:04 2019 +0000
        "url": "https://boringssl.googlesource.com/boringssl/+archive/0131fdd1b2e5562109ec74515ee6f5531d881322.tar.gz",
        # don't attempt to checksum this as it does not appear to be stable
        # "sha256": "",
    },

    # libssl is required for c++ grpc where it is expected in
    # //external:libssl.  This can be either boringssl or openssl.
    "libssl": {
        "rule": "bind",
        "actual": "@boringssl//:ssl",
    },

    "com_github_cares_cares": {
        "rule": "http_archive",
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

    # grpc++ expects //external:nanopb
    "nanopb": {
        "rule": "bind",
        "actual": "@com_github_grpc_grpc//third_party/nanopb",
    },

    # Bind the executable cc_binary grpc plugin into
    # //external:protoc_gen_grpc_cpp.  Expects
    # //external:protobuf_compiler. TODO: is it really necessary to
    # bind it in external?
    "protoc_gen_grpc_cpp": {
        "rule": "bind",
        "actual": "@com_github_grpc_grpc//:grpc_cpp_plugin",
    },

    # GTest is for our own internal cc tests.
    "com_google_googletest": {
        "rule": "http_archive",
        "url": "https://github.com/google/googletest/archive/7c6353d29a147cad1c904bf2957fd4ca2befe135.zip", # master Sept 1 2017
        "sha256": "f87029f647276734ef076785f76652347993b6d13ac1cbb2d2e976e16d2f8137",
        "strip_prefix": "googletest-7c6353d29a147cad1c904bf2957fd4ca2befe135",
    },

}
