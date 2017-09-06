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
        "url": "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.6.1/protoc-gen-grpc-java-1.6.1-linux-x86_64.exe",
        "sha256": "4229579f6e2b09fbcbee7fbe5b7a7c06e800da5759032a39bac2f22e570cbdc0",
    },

    "protoc_gen_grpc_java_macosx": {
        "rule": "http_file",
        "url": "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.6.1/protoc-gen-grpc-java-1.6.1-osx-x86_64.exe",
        "sha256": "9e3515e22e23a82927f37f6939990f2c668f5dfb9948853ec6a95ff14102a3bc",
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
        'artifact': 'com.google.errorprone:error_prone_annotations:2.0.11',
        'sha1': '3624d81fca4e93c67f43bafc222b06e1b1e3b260',
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
    'com_google_protobuf_protobuf_java': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf:protobuf-java:3.4.0',
        'sha1': 'b32aba0cbe737a4ca953f71688725972e3ee927c',
    },
    'com_google_protobuf_protobuf_java_util': {
        'rule': 'maven_jar',
        'artifact': 'com.google.protobuf:protobuf-java-util:3.3.1',
        'sha1': '35d048270e0b2f29e7e4a45daf21d46d1b121a24',
    },
    'io_grpc_grpc_context': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-context:1.6.1',
        'sha1': '9c52ae577c2dd4b8c6ac6e49c1154e1dc37d98ee',
    },
    'io_grpc_grpc_core': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-core:1.6.1',
        'sha1': '871c934f3c7fbb477ccf2dd4c2a47a0bcc1b82a9',
    },
    'io_grpc_grpc_netty': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-netty:1.6.1',
        'sha1': '6941e41b5f422da1670d5d01bf476644330b536e',
    },
    'io_grpc_grpc_protobuf': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-protobuf:1.6.1',
        'sha1': 'a309df5d2627422ceb9cb08fb6a240656d75760a',
    },
    'io_grpc_grpc_protobuf_lite': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-protobuf-lite:1.6.1',
        'sha1': '124bca81a50bc76b6a6babcc4bc529e5a93db70f',
    },
    'io_grpc_grpc_stub': {
        'rule': 'maven_jar',
        'artifact': 'io.grpc:grpc-stub:1.6.1',
        'sha1': 'f32b7ad69749ab6c7be5dd21f1e520a315418790',
    },
    'io_netty_netty_buffer': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-buffer:4.1.14.Final',
        'sha1': '71f0a707209b1356d924d6f8b2f415f8b8e1cf82',
    },
    'io_netty_netty_codec': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec:4.1.14.Final',
        'sha1': 'b8573ae401f17e6927f158e4c446311bf0646173',
    },
    'io_netty_netty_codec_http': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-http:4.1.14.Final',
        'sha1': 'f287b593a37e516f98c9dae7337303e7254e8ea1',
    },
    'io_netty_netty_codec_http2': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-http2:4.1.14.Final',
        'sha1': '00d2af27befab8e1abfbf37d1ac2a5185dce1dbe',
    },
    'io_netty_netty_codec_socks': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-codec-socks:4.1.14.Final',
        'sha1': 'b8d856c686ac960b9e9b9f8f9b4083978c161327',
    },
    'io_netty_netty_common': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-common:4.1.14.Final',
        'sha1': '230ff063651295d2695c0b4e9411e22bbbb9c09d',
    },
    'io_netty_netty_handler': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-handler:4.1.14.Final',
        'sha1': '626a48b846736c944eb35dd9b0fe0435b76ebf93',
    },
    'io_netty_netty_handler_proxy': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-handler-proxy:4.1.14.Final',
        'sha1': '9dbedd6cc6ab9299c927d0c73791d3d8fd76ac20',
    },
    'io_netty_netty_resolver': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-resolver:4.1.14.Final',
        'sha1': 'f91e0197522e7d33fce84b3dfd86ade15edb0006',
    },
    'io_netty_netty_transport': {
        'rule': 'maven_jar',
        'artifact': 'io.netty:netty-transport:4.1.14.Final',
        'sha1': '3ed6474f1289635fc0696ec37380e20f258950a2',
    },
    'io_opencensus_opencensus_api': {
        'rule': 'maven_jar',
        'artifact': 'io.opencensus:opencensus-api:0.5.1',
        'sha1': 'cbd0a716a7d85ac34b83d86b13f0a6655e45c2ba',
    },

}
