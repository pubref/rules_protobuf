DEPS = {

    # Grpc repo is required by multiple languages but we put it here.
   #  "com_github_grpc_grpc": {
   #      "rule": "git_repository",
   #      "remote": "https://github.com/grpc/grpc.git",
   #      "init_submodules": True,
   #      #"commit": "e8a1a50465d944ef321481e9a10f17a5284a0fa4", # Feb 22
   #      "commit": "f200f25d4dad5b74e7216a2b17fa2c2783ceb40e", # Apr 11
   # },

    # Hooray! The boringssl team provides a "master-with-bazel" branch
    # with all BUILD files ready to go.  To update, pick the
    # newest-ish commit-id off that branch.
    "boringssl": {
        "rule": "git_repository",
        "remote":  "https://boringssl.googlesource.com/boringssl",
        "commit": "14443198abcfc48f0420011a636b220e58e18610", # Nov 11 2016
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
        "actual": "@com_google_protobuf//:protobuf",
    },

    # grpc++ expects "//external:protobuf"
    "protobuf": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protobuf",
    },

    # grpc++ expects //external:nanopb
    "nanopb": {
        "rule": "bind",
        "actual": "@com_google_grpc//third_party/nanopb",
    },

    # grpc++ expects //external:cares
    "cares": {
        "rule": "bind",
        "actual": "@com_google_grpc//third_party/cares:ares",
    },

    # Bind the executable cc_binary grpc plugin into
    # //external:protoc_gen_grpc_cpp.  Expects
    # //external:protobuf_compiler. TODO: is it really necessary to
    # bind it in external?
    "protoc_gen_grpc_cpp": {
        "rule": "bind",
        "actual": "@com_google_grpc//:grpc_cpp_plugin",
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
