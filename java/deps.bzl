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

    # ##################################
    # Precompiled Plugins Dependencies #
    # ##################################

    "protoc_gen_grpc_java_linux_x86_64": {
        "rule": "http_file",
        "url": "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.13.1/protoc-gen-grpc-java-1.13.1-linux-x86_64.exe",
        "sha256": "0cffba550ba9ab914dd1ff22e8b26ebb74564a76dbf8bc525b09067c7fbd7c2d",
    },

    "protoc_gen_grpc_java_macosx": {
        "rule": "http_file",
        "url": "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.13.1/protoc-gen-grpc-java-1.13.1-osx-x86_64.exe",
        "sha256": "a71e6f04d422bf9e2cbfb49e5ad0138903af7cf7c204a425744e282c3d5dc54c",
    },

    "protoc_gen_grpc_java_windows_x86_64": {
        "rule": "http_file",
        "url": "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.13.1/protoc-gen-grpc-java-1.13.1-windows-x86_64.exe",
        "sha256": "4fcaf33d4edd4b2416c9360da1efe8ce0c739280ff8283df5290d7291c5ec739",
    },

    # ######################
    # Maven Dependencies #
    # ######################

    "junit_junit_4": {
        "rule": "maven_jar",
        "artifact": "junit:junit:jar:4.12",
        "sha1": "2973d150c0dc1fefe998f834810d68f278ea58ec",
    },

    # To recompute these one can do the following:
    # $ cd grpc-java-maven-deps/
    # $ bazel build :hello
    # $ cat $(bazel info output_base)/external/maven_grpc/rules.bzl >> ../deps.bzl
    # $ manually fix up this file with the new deps.
    #
    'com_google_api_grpc_proto_google_common_protos': {
        'rule': 'maven_jar',
        'artifact': 'com.google.api.grpc:proto-google-common-protos:1.12.0',
        'sha1': '1140cc74df039deb044ed0e320035e674dc13062',
    },
    'com_google_auth_google_auth_library_credentials': {
        'rule': 'maven_jar',
        'artifact': 'com.google.auth:google-auth-library-credentials:0.9.1',
        'sha1': '25e0f45f3b3d1b4fccc8944845e51a7a4f359652',
    },
    'com_google_code_findbugs_jsr305': {
        'rule': 'maven_jar',
        'artifact': 'com.google.code.findbugs:jsr305:3.0.2',
        'sha1': '25ea2e8b0c338a877313bd4672d3fe056ea78f0d',
    },
    'com_google_code_gson_gson': {
        'rule': 'maven_jar',
        'artifact': 'com.google.code.gson:gson:2.7',
        'sha1': '751f548c85fa49f330cecbb1875893f971b33c4e',
    },
    'com_google_errorprone_error_prone_annotations': {
        'rule': 'maven_jar',
        'artifact': 'com.google.errorprone:error_prone_annotations:2.1.2',
        'sha1': '6dcc08f90f678ac33e5ef78c3c752b6f59e63e0c',
    },
    'com_google_guava_guava': {
        'rule': 'maven_jar',
        'artifact': 'com.google.guava:guava:20.0',
        'sha1': '89507701249388e1ed5ddcf8c41f4ce1be7831ef',
    },
    'com_google_instrumentation_instrumentation_api': {
        'rule': 'maven_jar',
        'artifact': 'com.google.instrumentation:instrumentation-api:0.4.3',
        'sha1': '41614af3429573dc02645d541638929d877945a2',
    },
    'com_google_protobuf_nano_protobuf_javanano': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf.nano:protobuf-javanano:3.0.0-alpha-7',
        'sha1': '52587934797e3433992a9d69178a1471e4a8f85d',
    },
    'com_google_protobuf_protobuf_java': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf:protobuf-java:3.5.1',
        'sha1': '8c3492f7662fa1cbf8ca76a0f5eb1146f7725acd',
    },
    'com_google_protobuf_protobuf_lite': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf:protobuf-lite:3.0.1',
        'sha1': '59b5b9c6e1a3054696d23492f888c1f8b583f5fc',
    },
    'com_google_protobuf_protobuf_java_util': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf:protobuf-java-util:3.5.1',
        'sha1': '6e40a6a3f52455bd633aa2a0dba1a416e62b4575',
    },
    'com_squareup_okhttp_okhttp': {
        'rule': 'maven_jar',
        'artifact': 'com.squareup.okhttp:okhttp:2.5.0',
        'sha1': '4de2b4ed3445c37ec1720a7d214712e845a24636',
    },
    'com_squareup_okio_okio': {
        'rule': 'maven_jar',
        'artifact': 'com.squareup.okio:okio:1.13.0',
        'sha1': 'a9283170b7305c8d92d25aff02a6ab7e45d06cbe',
    },
    'io_grpc_grpc_all': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-all:1.13.1',
        'sha1': 'c4c949fb68c45b1f6884a1d2f536957b8cf156f6',
    },
    'io_grpc_grpc_auth': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-auth:1.13.1',
        'sha1': '096327e5774b7e0ed7f47043af9ff4fbc7f00f36',
    },
    'io_grpc_grpc_context': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-context:1.13.1',
        'sha1': 'e8d8407217ffe43996700f667fa1f6bee0a8c19a',
    },
    'io_grpc_grpc_core': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-core:1.13.1',
        'sha1': '74f5300e1e4d5c2abc0e4fc927d24f4f593c5a7d',
    },
    'io_grpc_grpc_netty': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-netty:1.13.1',
        'sha1': '24d4b1accd3c5dfe77fdf2823e1a8fa5df36f98e',
    },
    'io_grpc_grpc_okhttp': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-okhttp:1.13.1',
        'sha1': '3d3c28b53ea65d0b572ac8dc072d29f927d7ea1b',
    },
    'io_grpc_grpc_protobuf': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-protobuf:1.13.1',
        'sha1': '832f531a79249af2d9c1d50168301ba2bc45b54b',
    },
    'io_grpc_grpc_protobuf_lite': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-protobuf-lite:1.13.1',
        'sha1': '6ca13585100ad99e1c6140a7c8138dd96596aaf5',
    },
    'io_grpc_grpc_protobuf_nano': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-protobuf-nano:1.13.1',
        'sha1': 'de09dff24e3749c33c4e6c1ea2477c80a68c7f6a',
    },
    'io_grpc_grpc_stub': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-stub:1.13.1',
        'sha1': '2fc6e85e459ac522a3d81a78add8b6695f7525f1',
    },
    'io_netty_netty_buffer': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-buffer:4.1.25.Final',
        'sha1': 'f366d0cc87b158ca064d27507127e3cc4eb2f089',
    },
    'io_netty_netty_codec': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec:4.1.25.Final',
        'sha1': '3e465c75bead40d06b5b9c0612b37cf77c548887',
    },
    'io_netty_netty_codec_http': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-http:4.1.25.Final',
        'sha1': '70888d3f2a829541378f68503ddd52c3193df35a',
    },
    'io_netty_netty_codec_http2': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-http2:4.1.25.Final',
        'sha1': '20ffe2d83900da019b69bc557bf211737b322f71',
    },
    'io_netty_netty_codec_socks': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-socks:4.1.25.Final',
        'sha1': '81d672c2823d83825b4839673828bcf20fd53e2c',
    },
    'io_netty_netty_common': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-common:4.1.25.Final',
        'sha1': 'e17d5c05c101fe14536ce3fb34b36c54e04791f6',
    },
    'io_netty_netty_handler': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-handler:4.1.25.Final',
        'sha1': 'ecdfb8fe93a8b75db3ea8746d3437eed845c24bd',
    },
    'io_netty_netty_handler_proxy': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-handler-proxy:4.1.25.Final',
        'sha1': 'be053c1e9f4ac5463883aa7b692798ac7841359a',
    },
    'io_netty_netty_resolver': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-resolver:4.1.25.Final',
        'sha1': 'dc0965d00746b782b33f419b005cbc130973030d',
    },
    'io_netty_netty_transport': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-transport:4.1.25.Final',
        'sha1': '19a6f1f649894b6705aa9d8cbcced188dff133b0',
    },
    'io_opencensus_opencensus_api': {
        'rule': 'maven_jar',
        'artifact': 'io.opencensus:opencensus-api:0.12.3',
        'sha1': '743f074095f29aa985517299545e72cc99c87de0',
    },
    'io_opencensus_opencensus_contrib_grpc_metrics': {
        'rule': 'maven_jar',
        'artifact': 'io.opencensus:opencensus-contrib-grpc-metrics:0.12.3',
        'sha1': 'a4c7ff238a91b901c8b459889b6d0d7a9d889b4d',
    }
}
