# MAINTAINERS
#
# Every external rule must have a SHA checksum or tag.
#
# To update http_file(s) from maven servers, point your browser to
# https://repo1.maven.org/maven2/com/google/protobuf/protoc, find the
# file, copy it down to your workstation (with curl perhaps), and
# compute the sha256:
#
# $ curl -O -J -L https://repo1.maven.org/maven2/com/google/protobuf/protoc/3.0.0/protoc-3.0.0-linux-x86_64.exe
# $ sha256sum protoc-3.0.0-linux-x86_64.exe #linux
# $ shasum -a256 protoc-3.0.0-osx-x86_64.exe # macosx
#

DEPS = {

    # ######################
    # Compile Dependencies #
    # ######################

    "com_google_code_findbugs_jsr305": {
        "rule": "maven_jar",
        "artifact": "com.google.code.findbugs:jsr305:jar:3.0.1",
        "sha1": "f7be08ec23c21485b9b5a1cf1654c2ec8c58168d",
    },

    "com_google_guava_guava": {
        "rule": "maven_jar",
        "artifact": "com.google.guava:guava:jar:19.0",
        "sha1": "6ce200f6b23222af3d8abb6b6459e6c44f4bb0e9",
    },

    "io_grpc_grpc_core": {
        "rule": "maven_jar",
        "artifact": "io.grpc:grpc-core:jar:1.0.1",
        "sha1": "dce1c939c2c6110ac571d99f8d2a29b19bdad4db",
    },

    "io_grpc_grpc_protobuf": {
        "rule": "maven_jar",
        "artifact": "io.grpc:grpc-protobuf:jar:1.0.1",
        "sha1": "17222b03c64a65eb05de5ab266c920fca8c90fab",
    },

    "com_google_protobuf_protobuf_java": {
        "rule": "maven_jar",
        "artifact": "com.google.protobuf:protobuf-java:jar:3.1.0",
        "sha1": "e13484d9da178399d32d2d27ee21a77cfb4b7873",
    },

    "com_google_protobuf_protobuf_java_util": {
        "rule": "maven_jar",
        "artifact": "com.google.protobuf:protobuf-java-util:jar:3.1.0",
        "sha1": "5085a47f398f229ef2f07fb496099461e8f4c56c",
    },

    "io_grpc_grpc_protobuf_lite": {
        "rule": "maven_jar",
        "artifact": "io.grpc:grpc-protobuf-lite:jar:1.0.1",
        "sha1": "b28a07b56ed2e66088221cbaf1228fa4e9669166",
    },

    "com_google_code_gson_gson": {
        "rule": "maven_jar",
        "artifact": "com.google.code.gson:gson:jar:2.3",
        "sha1": "5fc52c41ef0239d1093a1eb7c3697036183677ce",
    },

    "io_grpc_grpc_stub": {
        "rule": "maven_jar",
        "artifact": "io.grpc:grpc-stub:jar:1.0.1",
        "sha1": "a875969bf700b0d25dc8b7febe42bfb253ca5b3b",
    },

    "junit_junit_4": {
        "rule": "maven_jar",
        "artifact": "junit:junit:jar:4.12",
        "sha1": "2973d150c0dc1fefe998f834810d68f278ea58ec",
    },

    # ######################
    # Runtime Dependencies #
    # ######################

    "io_grpc_grpc_context": {
        "rule": "maven_jar",
        "artifact": "io.grpc:grpc-context:jar:1.0.1",
        "sha1": "9d308f2b616044ddd380866b4e6c23b5b4020963",
    },

    "io_grpc_grpc_netty": {
        "rule": "maven_jar",
        "artifact": "io.grpc:grpc-netty:jar:1.0.1",
        "sha1": "1e4628b96434fcd6fbe519e7a3dbcc1ec5ac2c14",
    },

    "io_netty_netty_buffer": {
        "rule": "maven_jar",
        "artifact": "io.netty:netty-buffer:jar:4.1.3.Final",
        "sha1": "e507ffb52a1d134679ed244ff819a99e96782dc4",
    },

    "io_netty_netty_codec": {
        "rule": "maven_jar",
        "artifact": "io.netty:netty-codec:jar:4.1.3.Final",
        "sha1": "790174576b97ab75a4edafd320f9a964a5473cdb",
    },

    "io_netty_netty_codec_http": {
        "rule": "maven_jar",
        "artifact": "io.netty:netty-codec-http:jar:4.1.3.Final",
        "sha1": "62fdf3c43f2674a61ad761b3d164b34dbe76e6cc",
    },

    "io_netty_netty_codec_http2": {
        "rule": "maven_jar",
        "artifact": "io.netty:netty-codec-http2:jar:4.1.3.Final",
        "sha1": "4e68c878d8ae6988eb3425d4fc2c8d3eea69ff39",
    },

    "io_netty_netty_common": {
        "rule": "maven_jar",
        "artifact": "io.netty:netty-common:jar:4.1.3.Final",
        "sha1": "620faa6dd83a08eb607c9d5c077a9b4edde3056b",
    },

    "io_netty_netty_handler": {
        "rule": "maven_jar",
        "artifact": "io.netty:netty-handler:jar:4.1.3.Final",
        "sha1": "0fff45bdc544a4eeceb5b4c6e3e571627af9fdb6",
    },

    "io_netty_netty_resolver": {
        "rule": "maven_jar",
        "artifact": "io.netty:netty-resolver:jar:4.1.3.Final",
        "sha1": "fe4ba2ed19e4e8667068e917665f5725ee0290ea",
    },

    "io_netty_netty_transport": {
        "rule": "maven_jar",
        "artifact": "io.netty:netty-transport:jar:4.1.3.Final",
        "sha1": "2f17fe8c5c3b3f90908ed2d0649631a11beb3904",
    },

    # ###################
    # Nano Dependencies #
    # ###################
    # Todo: drop these in favor of lite?

    "com_google_protobuf_nano_protobuf_javanano": {
        "rule": "maven_jar",
        "artifact": "com.google.protobuf.nano:protobuf-javanano:jar:3.0.0-alpha-5",
        "sha1": "357e60f95cebb87c72151e49ba1f570d899734f8",
    },

    "io_grpc_grpc_protobuf_nano": {
        "rule": "maven_jar",
        "artifact": "io.grpc:grpc-protobuf-nano:jar:1.0.1",
        "sha1": "a0881f36976030d2b5a573677e7dd4752cedf760",
    },

    # ###################
    # Auth Dependencies #
    # ###################

    "com_google_auth_google_auth_library_credentials": {
        "rule": "maven_jar",
        "artifact": "com.google.auth:google-auth-library-credentials:jar:0.4.0",
        "sha1": "171da91494a1391aef13b88bd7302b29edb8d3b3",
    },

    "io_grpc_grpc_auth": {
        "rule": "maven_jar",
        "artifact": "io.grpc:grpc-auth:jar:1.0.1",
        "sha1": "5e1d053277e113ed7b7c71b5c1cbc32a8b4d3a83",
    },

    # ######################
    # Auth?  Dependencies #
    # ######################

    "io_grpc_grpc_okhttp": {
        "rule": "maven_jar",
        "artifact": "io.grpc:grpc-okhttp:jar:1.0.1",
        "sha1": "3cd4e41931268eef7c1ce00a2baecba6e53cb1da",
    },

    "com_squareup_okhttp_okhttp": {
        "rule": "maven_jar",
        "artifact": "com.squareup.okhttp:okhttp:jar:2.5.0",
        "sha1": "4de2b4ed3445c37ec1720a7d214712e845a24636",
    },

    "com_squareup_okio_okio": {
        "rule": "maven_jar",
        "artifact": "com.squareup.okio:okio:jar:1.6.0",
        "sha1": "98476622f10715998eacf9240d6b479f12c66143",
    },

    # ##################################
    # Precompiled Plugins Dependencies #
    # ##################################

    "protoc_gen_grpc_java_linux_x86_64": {
        "rule": "http_file",
        "url": "http://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.0.1/protoc-gen-grpc-java-1.0.1-linux-x86_64.exe",
        "sha256": "00497e9da3b8a068470bdf39b43f25084d9662e1419b01c2b3d9c29292fe0303",
    },

    "protoc_gen_grpc_java_macosx": {
        "rule": "http_file",
        "url": "http://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.0.1/protoc-gen-grpc-java-1.0.1-osx-x86_64.exe",
        "sha256": "cb4762ee4bde80fee5a35409474d6f177a2005e76d41590066e09be180af7781",
    },

}
