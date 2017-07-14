DEPS = {

    # Grpc repo is required by multiple languages but we put it here.
    "com_github_grpc_grpc": {
        "rule": "git_repository",
        "remote": "https://github.com/grpc/grpc.git",
        "init_submodules": True,
        "commit": "3808b6efe66b87269d43847bc113e94e2d3d28fb",
        #"tag": "v1.0.1",
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
