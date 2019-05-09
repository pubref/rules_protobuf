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
        "urls": ["https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.9.0/protoc-gen-grpc-java-1.9.0-linux-x86_64.exe"],
        "sha256": "f20cc8c052eea904c5a979c140237696e3f187f35deac49cd70b16dc0635f463",
    },

    "protoc_gen_grpc_java_macosx": {
        "rule": "http_file",
        "urls": ["http://central.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.9.0/protoc-gen-grpc-java-1.9.0-osx-x86_64.exe"],
        "sha256": "593937361f99e8b145fe29c78c71cdd00e8327ae88de010729479eb2acdc1de9",
    },

    "protoc_gen_grpc_java_windows_x86_64": {
        "rule": "http_file",
        "urls": ["https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.9.0/protoc-gen-grpc-java-1.9.0-windows-x86_64.exe"],
        "sha256": "28ee62f58f14fa1d33666e02c2c9dcca77ea98427446543c0ba00b7ea597d292",
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
        'artifact': 'com.google.api.grpc:proto-google-common-protos:1.0.0',
        'sha1': '86f070507e28b930e50d218ee5b6788ef0dd05e6',
    },
    'com_google_auth_google_auth_library_credentials': {
        'rule': 'maven_jar',
        'artifact': 'com.google.auth:google-auth-library-credentials:0.9.0',
        'sha1': '8e2b181feff6005c9cbc6f5c1c1e2d3ec9138d46',
    },
    'com_google_code_findbugs_jsr305': {
        'rule': 'maven_jar',
        'artifact': 'com.google.code.findbugs:jsr305:3.0.0',
        'sha1': '5871fb60dc68d67da54a663c3fd636a10a532948',
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
        'artifact': 'com.google.guava:guava:19.0',
        'sha1': '6ce200f6b23222af3d8abb6b6459e6c44f4bb0e9',
    },
    'com_google_instrumentation_instrumentation_api': {
        'rule': 'maven_jar',
        'artifact': 'com.google.instrumentation:instrumentation-api:0.4.3',
        'sha1': '41614af3429573dc02645d541638929d877945a2',
    },
    'com_google_protobuf_nano_protobuf_javanano': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf.nano:protobuf-javanano:3.0.0-alpha-5',
        'sha1': '357e60f95cebb87c72151e49ba1f570d899734f8',
    },
    'com_google_protobuf_protobuf_java': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf:protobuf-java:3.5.1',
        'sha1': '8c3492f7662fa1cbf8ca76a0f5eb1146f7725acd',
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
        'artifact': 'com.squareup.okio:okio:1.6.0',
        'sha1': '98476622f10715998eacf9240d6b479f12c66143',
    },
    'io_grpc_grpc_all': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-all:1.9.0',
        'sha1': '442dfac27fd072e15b7134ab02c2b38136036090',
    },
    'io_grpc_grpc_auth': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-auth:1.9.0',
        'sha1': 'd2eadc6d28ebee8ec0cef74f882255e4069972ad',
    },
    'io_grpc_grpc_context': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-context:1.9.0',
        'sha1': '28b0836f48c9705abf73829bbc536dba29a1329a',
    },
    'io_grpc_grpc_core': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-core:1.9.0',
        'sha1': 'cf76ab13d35e8bd5d0ffad6d82bb1ef1770f050c',
    },
    'io_grpc_grpc_netty': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-netty:1.9.0',
        'sha1': '8157384d87497dc18604a5ba3760763fe643f16e',
    },
    'io_grpc_grpc_okhttp': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-okhttp:1.9.0',
        'sha1': '4e7fbb9d3cd65848f42494de165b1c5839f69a8a',
    },
    'io_grpc_grpc_protobuf': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-protobuf:1.9.0',
        'sha1': '94ca247577e4cf1a38d5ac9d536ac1d426a1ccc5',
    },
    'io_grpc_grpc_protobuf_lite': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-protobuf-lite:1.9.0',
        'sha1': '9dc9c6531ae0b304581adff0e9b7cff21a4073ac',
    },
    'io_grpc_grpc_protobuf_nano': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf:protobuf-java:3.5.1',
        'sha1': '8c3492f7662fa1cbf8ca76a0f5eb1146f7725acd',
    },
    'io_grpc_grpc_stub': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-stub:1.9.0',
        'sha1': '20e310f888860a27dfa509a69eebb236417ee93f',
    },
    'io_netty_netty_buffer': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-buffer:4.1.17.Final',
        'sha1': 'fdd68fb3defd7059a7392b9395ee941ef9bacc25',
    },
    'io_netty_netty_codec': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec:4.1.17.Final',
        'sha1': '1d00f56dc9e55203a4bde5aae3d0828fdeb818e7',
    },
    'io_netty_netty_codec_http': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-http:4.1.17.Final',
        'sha1': '251d7edcb897122b9b23f24ff793cd0739056b9e',
    },
    'io_netty_netty_codec_http2': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-http2:4.1.17.Final',
        'sha1': 'f9844005869c6d9049f4b677228a89fee4c6eab3',
    },
    'io_netty_netty_codec_socks': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-socks:4.1.17.Final',
        'sha1': 'a159bf1f3d5019e0d561c92fbbec8400967471fa',
    },
    'io_netty_netty_common': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-common:4.1.17.Final',
        'sha1': '581c8ee239e4dc0976c2405d155f475538325098',
    },
    'io_netty_netty_handler': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-handler:4.1.17.Final',
        'sha1': '18c40ffb61a1d1979eca024087070762fdc4664a',
    },
    'io_netty_netty_handler_proxy': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-handler-proxy:4.1.17.Final',
        'sha1': '9330ee60c4e48ca60aac89b7bc5ec2567e84f28e',
    },
    'io_netty_netty_resolver': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-resolver:4.1.17.Final',
        'sha1': '8f386c80821e200f542da282ae1d3cde5cad8368',
    },
    'io_netty_netty_transport': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-transport:4.1.17.Final',
        'sha1': '9585776b0a8153182412b5d5366061ff486914c1',
    },
    'io_opencensus_opencensus_api': {
        'rule': 'maven_jar',
        'artifact': 'io.opencensus:opencensus-api:0.10.0',
        'sha1': '46bcf07e0bd835022ccd531d99c3eb813382d4d8',
    },
    'io_opencensus_opencensus_contrib_grpc_metrics': {
        'rule': 'maven_jar',
        'artifact': 'io.opencensus:opencensus-contrib-grpc-metrics:0.10.0',
        'sha1': 'e47f918dc577b6316f57a884c500b13a98d3c11b',
    }
}
