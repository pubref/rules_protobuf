DEPS = {

    # Grpc repo is required by multiple languages but we put it here.
    # This is the source archive for the 'grpc_repository' rule, were
    # we'll reconstruct a new repo by symlinking resources from here
    # into 'com_github_grpc_grpc'.
    "com_google_grpc": {
        "rule": "http_archive",
        "url": "https://github.com/grpc/grpc/archive/f5600e99be0fdcada4b3039c0f656a305264884a.zip", # Sep 1, 2017
        "sha256": "95ee013fdb605f9d4f47b1abcedc119f41d66d94ebc7af665c2866d4167e506e",
        "strip_prefix": "grpc-f5600e99be0fdcada4b3039c0f656a305264884a",
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
        "rule": "git_repository",
        "remote":  "https://boringssl.googlesource.com/boringssl",
        "commit": "8d8d1ca8e1f1a34a2167f59e2b0ca09c623b160f", # Jun 07 2017
    },

    # libssl is required for c++ grpc where it is expected in
    # //external:libssl.  This can be either boringssl or openssl.
    "libssl": {
        "rule": "bind",
        "actual": "@boringssl//:ssl",
    },

    # C-library for zlib
    "com_github_madler_zlib": {
        "rule": "new_git_repository",
        "remote": "https://github.com/madler/zlib",
        "tag": "v1.2.11",
        "build_file": str(Label("//protobuf:build_file/com_github_madler_zlib.BUILD")),
    },

    # grpc++ expects //external:cares
    "cares": {
        "rule": "bind",
        "actual": "@com_github_grpc_grpc//third_party/cares:ares",
    },

    # grpc++ expects //external:zlib
    "zlib": {
        "rule": "bind",
        "actual": "@com_github_madler_zlib//:zlib",
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

    # Bind the protobuf proto_lib into //external.  Required for
    # compiling the protoc_gen_grpc plugin
    "protocol_compiler": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protoc",
    },

    # GTest is for our own internal cc tests.
    "gtest": {
        "rule": "new_git_repository",
        "remote": "https://github.com/google/googletest.git",
        "commit": "ed9d1e1ff92ce199de5ca2667a667cd0a368482a",
        "build_file": str(Label("//protobuf:build_file/gtest.BUILD")),
    },

}
