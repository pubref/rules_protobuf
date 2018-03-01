# Language dependencies for rules_protobuf
To update this list, `bazel build @org_pubref_rules_protobuf//:deps && cp bazel-bin/DEPENDENCIES.md .`

## Protobuf

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [http_archive](https://docs.bazel.build/versions/master/be/workspace.html#http_archive) | **`@com_google_protobuf`** | [sha256:1f8b9b202e9a](https://github.com/google/protobuf/archive/v3.5.1.zip) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protoc`** | `//external:protoc` (`@com_google_protobuf//:protoc`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protocol_compiler`** | `//external:protocol_compiler` (`@com_google_protobuf//:protoc`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protobuf`** | `//external:protobuf` (`@com_google_protobuf//:protobuf`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protobuf_clib`** | `//external:protobuf_clib` (`@com_google_protobuf//:protoc_lib`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protobuf_headers`** | `//external:protobuf_headers` (`@com_google_protobuf//:protobuf_headers`) |

## C++

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| grpc_archive | **`@com_github_grpc_grpc`** |  |
| [http_archive](https://docs.bazel.build/versions/master/be/workspace.html#http_archive) | **`@boringssl`** | [(no hash provided)](https://boringssl.googlesource.com/boringssl/+archive/886e7d75368e3f4fab3f4d0d3584e4abfc557755.tar.gz) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@libssl`** | `//external:libssl` (`@boringssl//:ssl`) |
| [new_http_archive](https://docs.bazel.build/versions/master/be/workspace.html#new_http_archive) | **`@com_github_madler_zlib`** | [sha256:1cce3828ec2b](https://github.com/madler/zlib/archive/cacf7f1d4e3d44d871b605da3b647f07d718623f.zip) |
| [new_http_archive](https://docs.bazel.build/versions/master/be/workspace.html#new_http_archive) | **`@com_github_cares_cares`** | [sha256:932bf7e593d4](https://github.com/c-ares/c-ares/archive/3be1924221e1326df520f8498d704a5c4c8d0cce.zip) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@cares`** | `//external:cares` (`@com_github_cares_cares//:ares`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@zlib`** | `//external:zlib` (`@com_github_madler_zlib//:zlib`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@nanopb`** | `//external:nanopb` (`@com_github_grpc_grpc//third_party/nanopb`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protoc_gen_grpc_cpp`** | `//external:protoc_gen_grpc_cpp` (`@com_github_grpc_grpc//:grpc_cpp_plugin`) |
| [http_archive](https://docs.bazel.build/versions/master/be/workspace.html#http_archive) | **`@com_google_googletest`** | [sha256:f87029f64727](https://github.com/google/googletest/archive/7c6353d29a147cad1c904bf2957fd4ca2befe135.zip) |

## Java

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [http_file](https://docs.bazel.build/versions/master/be/workspace.html#http_file) | **`@protoc_gen_grpc_java_linux_x86_64`** | [sha256:f20cc8c052ee](https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.9.0/protoc-gen-grpc-java-1.9.0-linux-x86_64.exe) |
| [http_file](https://docs.bazel.build/versions/master/be/workspace.html#http_file) | **`@protoc_gen_grpc_java_macosx`** | [sha256:593937361f99](http://central.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.9.0/protoc-gen-grpc-java-1.9.0-osx-x86_64.exe) |
| [http_file](https://docs.bazel.build/versions/master/be/workspace.html#http_file) | **`@protoc_gen_grpc_java_windows_x86_64`** | [sha256:28ee62f58f14](https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.9.0/protoc-gen-grpc-java-1.9.0-windows-x86_64.exe) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@junit_junit_4`** | [junit:junit:jar:4.12](http:repo1.maven.org/maven2/junit/junit/jar) (2973d1) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_api_grpc_proto_google_common_protos`** | [com.google.api.grpc:proto-google-common-protos:1.0.0](http:repo1.maven.org/maven2/com/google/api/grpc/proto-google-common-protos/1.0.0) (86f070) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_auth_google_auth_library_credentials`** | [com.google.auth:google-auth-library-credentials:0.9.0](http:repo1.maven.org/maven2/com/google/auth/google-auth-library-credentials/0.9.0) (8e2b18) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_code_findbugs_jsr305`** | [com.google.code.findbugs:jsr305:3.0.0](http:repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.0) (5871fb) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_code_gson_gson`** | [com.google.code.gson:gson:2.7](http:repo1.maven.org/maven2/com/google/code/gson/gson/2.7) (751f54) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_errorprone_error_prone_annotations`** | [com.google.errorprone:error_prone_annotations:2.1.2](http:repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.1.2) (6dcc08) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_guava_guava`** | [com.google.guava:guava:19.0](http:repo1.maven.org/maven2/com/google/guava/guava/19.0) (6ce200) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_instrumentation_instrumentation_api`** | [com.google.instrumentation:instrumentation-api:0.4.3](http:repo1.maven.org/maven2/com/google/instrumentation/instrumentation-api/0.4.3) (41614a) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_protobuf_nano_protobuf_javanano`** | [com.google.protobuf.nano:protobuf-javanano:3.0.0-alpha-5](http:repo1.maven.org/maven2/com/google/protobuf/nano/protobuf-javanano/3.0.0-alpha-5) (357e60) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_protobuf_protobuf_java`** | [com.google.protobuf:protobuf-java:3.5.1](http:repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.5.1) (8c3492) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_protobuf_protobuf_java_util`** | [com.google.protobuf:protobuf-java-util:3.5.1](http:repo1.maven.org/maven2/com/google/protobuf/protobuf-java-util/3.5.1) (6e40a6) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_squareup_okhttp_okhttp`** | [com.squareup.okhttp:okhttp:2.5.0](http:repo1.maven.org/maven2/com/squareup/okhttp/okhttp/2.5.0) (4de2b4) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_squareup_okio_okio`** | [com.squareup.okio:okio:1.6.0](http:repo1.maven.org/maven2/com/squareup/okio/okio/1.6.0) (984766) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_all`** | [io.grpc:grpc-all:1.9.0](http:repo1.maven.org/maven2/io/grpc/grpc-all/1.9.0) (442dfa) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_auth`** | [io.grpc:grpc-auth:1.9.0](http:repo1.maven.org/maven2/io/grpc/grpc-auth/1.9.0) (d2eadc) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_context`** | [io.grpc:grpc-context:1.9.0](http:repo1.maven.org/maven2/io/grpc/grpc-context/1.9.0) (28b083) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_core`** | [io.grpc:grpc-core:1.9.0](http:repo1.maven.org/maven2/io/grpc/grpc-core/1.9.0) (cf76ab) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_netty`** | [io.grpc:grpc-netty:1.9.0](http:repo1.maven.org/maven2/io/grpc/grpc-netty/1.9.0) (815738) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_okhttp`** | [io.grpc:grpc-okhttp:1.9.0](http:repo1.maven.org/maven2/io/grpc/grpc-okhttp/1.9.0) (4e7fbb) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_protobuf`** | [io.grpc:grpc-protobuf:1.9.0](http:repo1.maven.org/maven2/io/grpc/grpc-protobuf/1.9.0) (94ca24) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_protobuf_lite`** | [io.grpc:grpc-protobuf-lite:1.9.0](http:repo1.maven.org/maven2/io/grpc/grpc-protobuf-lite/1.9.0) (9dc9c6) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_protobuf_nano`** | [com.google.protobuf:protobuf-java:3.5.1](http:repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.5.1) (8c3492) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_stub`** | [io.grpc:grpc-stub:1.9.0](http:repo1.maven.org/maven2/io/grpc/grpc-stub/1.9.0) (20e310) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_buffer`** | [io.netty:netty-buffer:4.1.17.Final](http:repo1.maven.org/maven2/io/netty/netty-buffer/4.1.17.Final) (fdd68f) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_codec`** | [io.netty:netty-codec:4.1.17.Final](http:repo1.maven.org/maven2/io/netty/netty-codec/4.1.17.Final) (1d00f5) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_codec_http`** | [io.netty:netty-codec-http:4.1.17.Final](http:repo1.maven.org/maven2/io/netty/netty-codec-http/4.1.17.Final) (251d7e) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_codec_http2`** | [io.netty:netty-codec-http2:4.1.17.Final](http:repo1.maven.org/maven2/io/netty/netty-codec-http2/4.1.17.Final) (f98440) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_codec_socks`** | [io.netty:netty-codec-socks:4.1.17.Final](http:repo1.maven.org/maven2/io/netty/netty-codec-socks/4.1.17.Final) (a159bf) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_common`** | [io.netty:netty-common:4.1.17.Final](http:repo1.maven.org/maven2/io/netty/netty-common/4.1.17.Final) (581c8e) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_handler`** | [io.netty:netty-handler:4.1.17.Final](http:repo1.maven.org/maven2/io/netty/netty-handler/4.1.17.Final) (18c40f) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_handler_proxy`** | [io.netty:netty-handler-proxy:4.1.17.Final](http:repo1.maven.org/maven2/io/netty/netty-handler-proxy/4.1.17.Final) (9330ee) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_resolver`** | [io.netty:netty-resolver:4.1.17.Final](http:repo1.maven.org/maven2/io/netty/netty-resolver/4.1.17.Final) (8f386c) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_transport`** | [io.netty:netty-transport:4.1.17.Final](http:repo1.maven.org/maven2/io/netty/netty-transport/4.1.17.Final) (958577) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_opencensus_opencensus_api`** | [io.opencensus:opencensus-api:0.10.0](http:repo1.maven.org/maven2/io/opencensus/opencensus-api/0.10.0) (46bcf0) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_opencensus_opencensus_contrib_grpc_metrics`** | [io.opencensus:opencensus-contrib-grpc-metrics:0.10.0](http:repo1.maven.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.10.0) (e47f91) |

## C#

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [new_nuget_package](https://github.com/bazelbuild/rules_dotnet#new_nuget_package) | **`@nuget_google_protobuf`** | [Google.Protobuf@3.4.0](https://www.nuget.org/packages/Google.Protobuf) |
| [new_nuget_package](https://github.com/bazelbuild/rules_dotnet#new_nuget_package) | **`@nuget_grpc`** | [Grpc@1.6.0](https://www.nuget.org/packages/Grpc) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protoc_gen_grpc_csharp`** | `//external:protoc_gen_grpc_csharp` (`@com_github_grpc_grpc//:grpc_csharp_plugin`) |

## Go

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [go_repository](https://github.com/bazelbuild/rules_go#go_repository) | **`@org_golang_google_grpc`** | [google.golang.org/grpc](https://google.golang.org/grpc/) |
| [go_repository](https://github.com/bazelbuild/rules_go#go_repository) | **`@org_golang_google_genproto`** | [google.golang.org/genproto](https://google.golang.org/genproto/) |
| [go_repository](https://github.com/bazelbuild/rules_go#go_repository) | **`@org_golang_x_net`** | [golang.org/x/net](https://golang.org/x/net/) |
| [go_repository](https://github.com/bazelbuild/rules_go#go_repository) | **`@org_golang_x_text`** | [golang.org/x/text](https://golang.org/x/text/) |
| [go_repository](https://github.com/bazelbuild/rules_go#go_repository) | **`@com_github_golang_glog`** | [github.com/golang/glog](https://github.com/golang/glog/) |
| [go_repository](https://github.com/bazelbuild/rules_go#go_repository) | **`@com_github_golang_protobuf`** | [github.com/golang/protobuf](https://github.com/golang/protobuf/) |

## Gogo

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [go_repository](https://github.com/bazelbuild/rules_go#go_repository) | **`@com_github_gogo_protobuf`** | [github.com/gogo/protobuf](https://github.com/gogo/protobuf/) |

## Grpc Gateway

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [go_repository](https://github.com/bazelbuild/rules_go#go_repository) | **`@com_github_grpc_ecosystem_grpc_gateway`** | [github.com/grpc-ecosystem/grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway/) |
| [new_http_archive](https://docs.bazel.build/versions/master/be/workspace.html#new_http_archive) | **`@com_github_grpc_ecosystem_grpc_gateway_googleapis`** | [sha256:b8426c25492e](https://github.com/grpc-ecosystem/grpc-gateway/archive/f2862b476edcef83412c7af8687c9cd8e4097c0f.zip) |
| [go_repository](https://github.com/bazelbuild/rules_go#go_repository) | **`@org_golang_google_genproto`** | [google.golang.org/genproto](https://google.golang.org/genproto/) |

## Node

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protoc_gen_grpc_node`** | `//external:protoc_gen_grpc_node` (`@com_github_grpc_grpc//:grpc_node_plugin`) |
| [npm_repository](https://github.com/pubref/rules_node#npm_repository) | **`@npm_protobuf_stack`** | [async@2.6.0](https://npmjs.org/package/async), [google-protobuf@3.5.0](https://npmjs.org/package/google-protobuf), [lodash@4.17.5](https://npmjs.org/package/lodash), [minimist@1.2.0](https://npmjs.org/package/minimist) |
| [npm_repository](https://github.com/pubref/rules_node#npm_repository) | **`@npm_grpc`** | [grpc@1.0.0](https://npmjs.org/package/grpc) |
