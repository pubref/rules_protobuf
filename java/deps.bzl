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
        "url": "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.7.0/protoc-gen-grpc-java-1.7.0-linux-x86_64.exe",
        "sha256": "a1e0035248b14162a45c7120a09c1474562302d42f4f7c92f63a45655dc183f7",
    },

    "protoc_gen_grpc_java_macosx": {
        "rule": "http_file",
        "url": "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.7.0/protoc-gen-grpc-java-1.7.0-osx-x86_64.exe",
        "sha256": "a9fdb363d05786c00541f83893cd34566bdc92e8d5355d6123d93c2b2885795d",
    },

    "protoc_gen_grpc_java_windows_x86_64": {
        "rule": "http_file",
        "url": "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.7.0/protoc-gen-grpc-java-1.7.0-windows-x86_64.exe",
        "sha256": "e579866c7ec42dd27838960abedb32bfc41debfa9ae0b9d45a286f1011ce5c43",
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
        'artifact': 'com.google.api.grpc:proto-google-common-protos:0.1.9',
        'sha1': '3760f6a6e13c8ab070aa629876cdd183614ee877',
    },
    'com_google_auth_google_auth_library_credentials': {
        'rule': 'maven_jar',
        'artifact': 'com.google.auth:google-auth-library-credentials:0.4.0',
        'sha1': '171da91494a1391aef13b88bd7302b29edb8d3b3',
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
        'artifact': 'com.google.errorprone:error_prone_annotations:2.0.19',
        'sha1': 'c3754a0bdd545b00ddc26884f9e7624f8b6a14de',
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
        'artifact': 'com.google.protobuf.nano:protobuf-javanano:3.0.0-alpha',
        'sha1': '357e60f95cebb87c72151e49ba1f570d899734f8',
    },
    'com_google_protobuf_protobuf_java': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf:protobuf-java:3.4.0',
        'sha1': 'b32aba0cbe737a4ca953f71688725972e3ee927c',
    },
    'com_google_protobuf_protobuf_java_util': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf:protobuf-java-util:3.4.0',
        'sha1': '96aba8ab71c16018c6adf66771ce15c6491bc0fe',
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
        'artifact': 'io.grpc:grpc-all:1.7.0',
        'sha1': '59340bc5e354e2cd8a4e7e7b7d44bd27f876e62e',
    },
    'io_grpc_grpc_auth': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-auth:1.7.0',
        'sha1': '7c7f0b0f8816657cdcfd654f17b866fd77b1546d',
    },
    'io_grpc_grpc_context': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-context:1.7.0',
        'sha1': 'e004fa243a627a64e91712154b93c5611d5c3af3',
    },
    'io_grpc_grpc_core': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-core:1.7.0',
        'sha1': '307405121aac5a31fa9b45dd883a8b3607ba7ab6',
    },
    'io_grpc_grpc_netty': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-netty:1.7.0',
        'sha1': '2ceeca086ba8388293dea4a26f524815f7f905d1',
    },
    'io_grpc_grpc_okhttp': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-okhttp:1.7.0',
        'sha1': '5b10f46007ef76d30779203d9acef06a13fd9b0c',
    },
    'io_grpc_grpc_protobuf': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-protobuf:1.7.0',
        'sha1': '2ee434bb315f074f176913c4293dd3b3bb63bccc',
    },
    'io_grpc_grpc_protobuf_lite': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-protobuf-lite:1.7.0',
        'sha1': 'a0e2a7b7498cdcdb4a37bbe2f781cd2259a6bdb2',
    },
    'io_grpc_grpc_protobuf_nano': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-protobuf-nano:1.7.0',
        'sha1': 'a5e51c61ab47b149d43a59d673d50ef5dd5bc396',
    },
    'io_grpc_grpc_stub': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-stub:1.7.0',
        'sha1': '0b80ca6416e1433648de7af49e62b12bf3c4a500',
    },
    'io_netty_netty_buffer': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-buffer:4.1.16.Final',
        'sha1': '63b5fa95c74785e16f2c30ce268bc222e35c8cb5',
    },
    'io_netty_netty_codec': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec:4.1.16.Final',
        'sha1': 'd84a1f21768b7309c2954521cf5a1f46c2309eb1',
    },
    'io_netty_netty_codec_http': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-http:4.1.16.Final',
        'sha1': 'd64312378b438dfdad84267c599a053327c6f02a',
    },
    'io_netty_netty_codec_http2': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-http2:4.1.16.Final',
        'sha1': '45c27cddac120a4fcda8f699659e59389f7b9736',
    },
    'io_netty_netty_codec_socks': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-socks:4.1.16.Final',
        'sha1': 'f42aabfb1dcae4eaf1700f2c2d047eab3c1b8523',
    },
    'io_netty_netty_common': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-common:4.1.16.Final',
        'sha1': '177a6b30cca92f6f5f9873c9befd681377a4c328',
    },
    'io_netty_netty_handler': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-handler:4.1.16.Final',
        'sha1': 'fec0e63e7dd7f4eeef7ea8dc47a1ff32dfc7ebc2',
    },
    'io_netty_netty_handler_proxy': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-handler-proxy:4.1.16.Final',
        'sha1': 'e3007ed3368748ccdc35c1f38c7d6c089768373a',
    },
    'io_netty_netty_resolver': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-resolver:4.1.16.Final',
        'sha1': 'f6eb553b53fb3a90a8ac1170697093fed82eae28',
    },
    'io_netty_netty_transport': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-transport:4.1.16.Final',
        'sha1': '3c8ee2c4d4a1cbb947a5c184c7aeb2204260958b',
    },
    'io_opencensus_opencensus_api': {
        'rule': 'maven_jar',
        'artifact': 'io.opencensus:opencensus-api:0.6.0',
        'sha1': '8e3cd27ac3634373aa4e7aba3c13fc5ac22cb6b7',
    },

}
