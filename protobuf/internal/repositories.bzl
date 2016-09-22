# ****************************************************************
# Master list of external dependencies
# ****************************************************************

# MAINTAINERS
#
# 1. Please sort everything in this file according to language.
#
# 2. Every external rule must have a SHA checksum or tag.
#
# 3. Use http:// URLs since we're relying on the checksum for security.
#
# To update http_file(s) from maven servers, point your browser to
# https://repo1.maven.org/maven2/com/google/protobuf/protoc, find the
# file, copy it down to your workstation (with curl perhaps), and
# compute the sha256:
#
# $ curl -O -J -L https://repo1.maven.org/maven2/com/google/protobuf/protoc/3.0.0/protoc-3.0.0-linux-x86_64.exe
# $ sha256sum protoc-3.0.0-linux-x86_64.exe #linux
# $ shasum -a256 protoc-3.0.0-osx-x86_64.exe # macosx

REPOSITORIES = {

    ### intended to be compatible with loose json parser to generate documentation from this.
    ###:begin

    # Protobuf required for multiple reasons, including the cc_binary
    # 'protoc' and the cc_library 'protobuf_clib'
    "protobuf": {
        "kind": "git_repository",
        "name": "com_github_google_protobuf",
        "remote": "https://github.com/google/protobuf.git",
        #"tag": "v3.0.0",
        "commit": "ff2a6600e5df21683b86aca7e30bbb80c0aed848",
    },

    # This binds the cc_binary "protoc" into //external:protoc.  This
    # is required for several protoc related rules in this repo. TODO:
    # document which ones, but includes grpc++
    "external_protoc": {
        "kind": "bind",
        "name": "protoc",
        "actual": "@com_github_google_protobuf//:protoc",
    },

    # ****************************************************************
    # CPP
    # ****************************************************************

    # Hooray! The boringssl team provides a "master-with-bazel" branch
    # with all BUILD files ready to go.  To update, pick the
    # newest-ish commit-id off that branch.
    "boringssl": {
        "kind": "git_repository",
        "name":  "boringssl", # use short version as this is what boringssl defines workspace as
        "remote":  "https://boringssl.googlesource.com/boringssl",
        "commit": "36b3ab3e5d3a4892444a698f7989f2150824d804", # Aug 3 2016
    },

    # Grpc repo is required by multiple languages
    "grpc": {
        "kind": "git_repository",
        "name": "com_github_grpc_grpc",
        "remote": "https://github.com/grpc/grpc.git",
        "init_submodules": True,
        "tag": "v0.15.2",
    },

    # libssl is required for c++ grpc where it is expected in
    # //external:libssl.  This can be either boringssl or openssl.
    "libssl": {
        "kind": "bind",
        "name": "libssl",
        "actual": "@boringssl//:ssl",
    },

    # C-library for zlib
    "zlib": {
        "kind": "new_git_repository",
        "name": "com_github_madler_zlib",
        "remote": "https://github.com/madler/zlib",
        "tag": "v1.2.8",
        "build_file": str(Label("//protobuf:build_file/com_github_madler_zlib.BUILD")),
    },

    # grpc++ expects //external:zlib
    "external_zlib": {
        "kind": "bind",
        "name": "zlib",
        "actual": "@com_github_madler_zlib//:zlib",
    },

    # grpc++ expects "//external:protobuf_clib"
    "external_protobuf_clib": {
        "kind": "bind",
        "name": "protobuf_clib",
        "actual": "@com_github_google_protobuf//:protobuf",
    },

    # grpc++ requires nanobp (and now has a BUILD file!)
    "nanopb": {
        "kind": "git_repository",
        "name": "com_github_nanopb_nanopb",
        "remote": "https://github.com/nanopb/nanopb.git",
        "commit": "0198210f2cc349e7bc5199e8db7f4afc8208d843", # Aug 2 2016
    },

    # grpc++ expects //external:nanopb
    "external_nanopb": {
        "kind": "bind",
        "name": "nanopb",
        "actual": "@com_github_nanopb_nanopb//:nanopb",
    },

    # Bind the executable cc_binary grpc plugin into //external:protoc_gen_grpc_cpp.  Expects
    # //external:protobuf_compiler.
    "external_protoc_gen_grpc_cpp": {
        "kind": "bind",
        "name": "protoc_gen_grpc_cpp",
        "actual": "@com_github_grpc_grpc//:grpc_cpp_plugin",
    },

    # Bind the protobuf proto_lib into //external.  Required for
    # compiling the protoc_gen_grpc plugin
    "external_protobuf_compiler": {
        "kind": "bind",
        "name": "protobuf_compiler",
        "actual": "@com_github_google_protobuf//:protoc_lib",
    },

    # # Bind the protobuf proto_lib (protoc) into //external.  Required
    # # for compiling the protoc_gen_grpc plugin
    "third_party_protoc": {
        "kind": "bind",
        "name": "third_party",
        "actual": "@com_github_google_protobuf//:protoc_lib",
    },

    # GTest is for our own internal cc tests.
    "gtest": {
        "kind": "new_git_repository",
        "name": "gtest",
        "remote": "https://github.com/google/googletest.git",
        "commit": "ed9d1e1ff92ce199de5ca2667a667cd0a368482a",
        "build_file": str(Label("//protobuf:build_file/gtest.BUILD")),
    },

    # ****************************************************************
    # GO
    # ****************************************************************

    "com_github_golang_glog": {
        "kind": "new_git_repository",
        "name": "com_github_golang_glog",
        "remote": "https://github.com/golang/glog.git",
        "commit": "23def4e6c14b4da8ac2ed8007337bc5eb5007998", # Jan 25, 2016
        "build_file": str(Label("//protobuf:build_file/com_github_golang_glog.BUILD")),
    },

    "com_github_golang_protobuf": {
        "kind": "new_git_repository",
        "name": "com_github_golang_protobuf",
        "remote": "https://github.com/golang/protobuf.git",
        "commit": "c3cefd437628a0b7d31b34fe44b3a7a540e98527", # Jul 27, 2016
        "build_file": str(Label("//protobuf:build_file/com_github_golang_protobuf.BUILD")),
    },

    "org_golang_google_grpc": {
        "kind": "new_git_repository",
        "name": "org_golang_google_grpc",
        "remote": "https://github.com/grpc/grpc-go.git",
        #"commit": "13edeeffdea7a41d5aad96c28deb4c7bd01a9397", #v1.0.0
        "tag": "v1.0.0",
        "build_file": str(Label("//protobuf:build_file/org_golang_google_grpc.BUILD")),
    },

    "org_golang_x_net": {
        "kind": "new_git_repository",
        "name": "org_golang_x_net",
        "remote": "https://github.com/golang/net.git",
        "commit": "2a35e686583654a1b89ca79c4ac78cb3d6529ca3",
        "build_file": str(Label("//protobuf:build_file/org_golang_x_net.BUILD")),
    },

    # ****************************************************************
    # grpc-gateway
    # ****************************************************************

    "com_github_grpc_ecosystem_grpc_gateway": {
        "kind": "new_git_repository",
        "name": "com_github_grpc_ecosystem_grpc_gateway",
        "remote": "https://github.com/grpc-ecosystem/grpc-gateway.git",
        "commit": "ccd4e6b091a44f9f6b32848ffc63b3e8f8e26092",
        "build_file": str(Label("//protobuf:build_file/com_github_grpc_ecosystem_grpc_gateway.BUILD")),
    },

    # ****************************************************************
    # JAVA
    # ****************************************************************

    "com_google_auth_google_auth_library_credentials": {
        "kind": "maven_jar",
        "name": "com_google_auth_google_auth_library_credentials",
        "artifact": "com.google.auth:google-auth-library-credentials:jar:0.4.0",
        "sha1": "171da91494a1391aef13b88bd7302b29edb8d3b3",
    },

    "com_google_code_gson_gson": {
        "kind": "maven_jar",
        "name": "com_google_code_gson_gson",
        "artifact": "com.google.code.gson:gson:jar:2.3",
        "sha1": "5fc52c41ef0239d1093a1eb7c3697036183677ce",
    },

    "com_google_code_findbugs_jsr305": {
        "kind": "maven_jar",
        "name": "com_google_code_findbugs_jsr305",
        "artifact": "com.google.code.findbugs:jsr305:jar:3.0.0",
        "sha1": "5871fb60dc68d67da54a663c3fd636a10a532948",
    },

    "com_google_guava_guava": {
        "kind": "maven_jar",
        "name": "com_google_guava_guava",
        "artifact": "com.google.guava:guava:jar:19.0",
        "sha1": "6ce200f6b23222af3d8abb6b6459e6c44f4bb0e9",
    },

    "com_google_protobuf_protobuf_java": {
        "kind": "maven_jar",
        "name": "com_google_protobuf_protobuf_java",
        "artifact": "com.google.protobuf:protobuf-java:jar:3.0.0",
        "sha1": "6d325aa7c921661d84577c0a93d82da4df9fa4c8",
    },

    "com_google_protobuf_nano_protobuf_javanano": {
        "kind": "maven_jar",
        "name": "com_google_protobuf_nano_protobuf_javanano",
        "artifact": "com.google.protobuf.nano:protobuf-javanano:jar:3.0.0-alpha-5",
        "sha1": "357e60f95cebb87c72151e49ba1f570d899734f8",
    },

    "com_google_protobuf_protobuf_java_util": {
        "kind": "maven_jar",
        "name": "com_google_protobuf_protobuf_java_util",
        "artifact": "com.google.protobuf:protobuf-java-util:jar:3.0.0",
        "sha1": "5c39485775c197fc1938e594dc358bfec1c188a0",
    },

    "com_squareup_okhttp_okhttp": {
        "kind": "maven_jar",
        "name": "com_squareup_okhttp_okhttp",
        "artifact": "com.squareup.okhttp:okhttp:jar:2.5.0",
        "sha1": "4de2b4ed3445c37ec1720a7d214712e845a24636",
    },

    "com_squareup_okio_okio": {
        "kind": "maven_jar",
        "name": "com_squareup_okio_okio",
        "artifact": "com.squareup.okio:okio:jar:1.6.0",
        "sha1": "98476622f10715998eacf9240d6b479f12c66143",
    },

    "io_grpc_grpc_auth": {
        "kind": "maven_jar",
        "name": "io_grpc_grpc_auth",
        "artifact": "io.grpc:grpc-auth:jar:1.0.0-pre1",
        "sha1": "f0f297a406c45ecc030e2aca69b81a7ed67c3de7",
    },

    "io_grpc_grpc_core": {
        "kind": "maven_jar",
        "name": "io_grpc_grpc_core",
        "artifact": "io.grpc:grpc-core:jar:1.0.0-pre1",
        "sha1": "6489670c182cb214cdcbbd7e6508b4f3ac831ce5",
    },

    "io_grpc_grpc_netty": {
        "kind": "maven_jar",
        "name": "io_grpc_grpc_netty",
        "artifact": "io.grpc:grpc-netty:jar:1.0.0-pre1",
        "sha1": "53094773926bf863daa8faa3ff1175f3f6909ca8",
    },

    "io_grpc_grpc_okhttp": {
        "kind": "maven_jar",
        "name": "io_grpc_grpc_okhttp",
        "artifact": "io.grpc:grpc-okhttp:jar:1.0.0-pre1",
        "sha1": "3cd4e41931268eef7c1ce00a2baecba6e53cb1da",
    },

    "io_grpc_grpc_protobuf": {
        "kind": "maven_jar",
        "name": "io_grpc_grpc_protobuf",
        "artifact": "io.grpc:grpc-protobuf:jar:1.0.0-pre1",
        "sha1": "9e5235fbae40a22fe97a4cd55333b18969ef76cb",
    },

    "io_grpc_grpc_protobuf_lite": {
        "kind": "maven_jar",
        "name": "io_grpc_grpc_protobuf_lite",
        "artifact": "io.grpc:grpc-protobuf-lite:jar:1.0.0-pre1",
        "sha1": "8ab07e256e0d9fb3650954f38bc09b5ea258b716",
    },

    "io_grpc_grpc_protobuf_nano": {
        "kind": "maven_jar",
        "name": "io_grpc_grpc_protobuf_nano",
        "artifact": "io.grpc:grpc-protobuf-nano:jar:1.0.0-pre1",
        "sha1": "c88ce3b66d21eadcdfecb8326ecd976b2aecbe9f",
    },

    "io_grpc_grpc_stub": {
        "kind": "maven_jar",
        "name": "io_grpc_grpc_stub",
        "artifact": "io.grpc:grpc-stub:jar:1.0.0-pre1",
        "sha1": "1fb325fdb52b0e5df3aea3a98b0f75119b2a3701",
    },

    "io_netty_netty_buffer": {
        "kind": "maven_jar",
        "name": "io_netty_netty_buffer",
        "artifact": "io.netty:netty-buffer:jar:4.1.3.Final",
        "sha1": "e507ffb52a1d134679ed244ff819a99e96782dc4",
    },

    "io_netty_netty_codec": {
        "kind": "maven_jar",
        "name": "io_netty_netty_codec",
        "artifact": "io.netty:netty-codec:jar:4.1.3.Final",
        "sha1": "790174576b97ab75a4edafd320f9a964a5473cdb",
    },

    "io_netty_netty_codec_http": {
        "kind": "maven_jar",
        "name": "io_netty_netty_codec_http",
        "artifact": "io.netty:netty-codec-http:jar:4.1.3.Final",
        "sha1": "62fdf3c43f2674a61ad761b3d164b34dbe76e6cc",
    },

    "io_netty_netty_codec_http2": {
        "kind": "maven_jar",
        "name": "io_netty_netty_codec_http2",
        "artifact": "io.netty:netty-codec-http2:jar:4.1.3.Final",
        "sha1": "4e68c878d8ae6988eb3425d4fc2c8d3eea69ff39",
    },

    "io_netty_netty_common": {
        "kind": "maven_jar",
        "name": "io_netty_netty_common",
        "artifact": "io.netty:netty-common:jar:4.1.3.Final",
        "sha1": "620faa6dd83a08eb607c9d5c077a9b4edde3056b",
    },

    "io_netty_netty_handler": {
        "kind": "maven_jar",
        "name": "io_netty_netty_handler",
        "artifact": "io.netty:netty-handler:jar:4.1.3.Final",
        "sha1": "0fff45bdc544a4eeceb5b4c6e3e571627af9fdb6",
    },

    "io_netty_netty_resolver": {
        "kind": "maven_jar",
        "name": "io_netty_netty_resolver",
        "artifact": "io.netty:netty-resolver:jar:4.1.3.Final",
        "sha1": "fe4ba2ed19e4e8667068e917665f5725ee0290ea",
    },

    "io_netty_netty_transport": {
        "kind": "maven_jar",
        "name": "io_netty_netty_transport",
        "artifact": "io.netty:netty-transport:jar:4.1.3.Final",
        "sha1": "2f17fe8c5c3b3f90908ed2d0649631a11beb3904",
    },

    "protoc_gen_grpc_java_linux_x86_64": {
        "kind": "http_file",
        "name": "protoc_gen_grpc_java_linux_x86_64",
        "url": "http://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.0.0-pre1/protoc-gen-grpc-java-1.0.0-pre1-linux-x86_64.exe",
        "sha256": "4245b79757ce78a64dbec6f7facf64e1ff74fee411ce5b090c1114e1b5ec46d7",
    },

    "protoc_gen_grpc_java_macosx": {
        "kind": "http_file",
        "name": "protoc_gen_grpc_java_macosx",
        "url": "http://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.0.0-pre1/protoc-gen-grpc-java-1.0.0-pre1-osx-x86_64.exe",
        "sha256": "850fd0420cb896dfcd1f7d1edd6b3cb010890f8732f84821af5ef6b5f89e885d",
    },

    "junit_junit_4": {
        "kind": "maven_jar",
        "name": "junit_junit_4",
        "artifact": "junit:junit:jar:4.12",
        "sha1": "2973d150c0dc1fefe998f834810d68f278ea58ec",
    },

    ###:end

}
