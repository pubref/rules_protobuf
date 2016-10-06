DEPS = {

    # Grpc repo is required by multiple languages but we put it here.
    "com_github_grpc_grpc": {
        "rule": "git_repository",
        "remote": "https://github.com/grpc/grpc.git",
        "init_submodules": True,
        "commit": "673fa6c88b8abd542ae50c4480de92880a1e4777",
    },

    # Hooray! The boringssl team provides a "master-with-bazel" branch
    # with all BUILD files ready to go.  To update, pick the
    # newest-ish commit-id off that branch.
    "boringssl": {
        "rule": "git_repository",
        "remote":  "https://boringssl.googlesource.com/boringssl",
        "commit": "36b3ab3e5d3a4892444a698f7989f2150824d804", # Aug 3 2016
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
        "tag": "v1.2.8",
        "build_file": str(Label("//protobuf:build_file/com_github_madler_zlib.BUILD")),
    },

    # grpc++ expects //external:zlib
    "zlib": {
        "rule": "bind",
        "actual": "@com_github_madler_zlib//:zlib",
    },

    # grpc++ expects "//external:protobuf_clib"
    "protobuf_clib": {
        "rule": "bind",
        "actual": "@com_github_google_protobuf//:protobuf",
    },

    # grpc++ requires nanobp (and now has a BUILD file!)
    "com_github_nanopb_nanopb": {
        "rule": "git_repository",
        "remote": "https://github.com/nanopb/nanopb.git",
        "commit": "91bb64a47b36b112c9b22391ef76fab29cf2cffc", # Sep 1 2016
    },

    # grpc++ expects //external:nanopb
    "nanopb": {
        "rule": "bind",
        "actual": "@com_github_nanopb_nanopb//:nanopb",
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
    "protobuf_compiler": {
        "rule": "bind",
        "actual": "@com_github_google_protobuf//:protoc_lib",
    },

    # GTest is for our own internal cc tests.
    "gtest": {
        "rule": "new_git_repository",
        "remote": "https://github.com/google/googletest.git",
        "commit": "ed9d1e1ff92ce199de5ca2667a667cd0a368482a",
        "build_file": str(Label("//protobuf:build_file/gtest.BUILD")),
    },

}
