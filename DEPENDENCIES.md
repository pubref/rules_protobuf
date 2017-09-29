# Language dependencies for rules_protobuf
To update this list, `bazel build @org_pubref_rules_protobuf//:deps && cp bazel-bin/DEPENDENCIES.md .`

## Protobuf

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [http_archive](https://docs.bazel.build/versions/master/be/workspace.html#http_archive) | **`@com_google_protobuf`** | [sha256:542703acadc3](https://github.com/google/protobuf/archive/v3.4.0.zip) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protoc`** | `//external:protoc` (`@com_google_protobuf//:protoc`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protocol_compiler`** | `//external:protocol_compiler` (`@com_google_protobuf//:protoc`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protobuf`** | `//external:protobuf` (`@com_google_protobuf//:protobuf`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protobuf_clib`** | `//external:protobuf_clib` (`@com_google_protobuf//:protoc_lib`) |

## C++

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [http_archive](https://docs.bazel.build/versions/master/be/workspace.html#http_archive) | **`@com_google_grpc_base`** | [sha256:95ee013fdb60](https://github.com/grpc/grpc/archive/f5600e99be0fdcada4b3039c0f656a305264884a.zip) |
| grpc_repository | **`@com_google_grpc`** |  |
| [new_http_archive](https://docs.bazel.build/versions/master/be/workspace.html#new_http_archive) | **`@com_github_c_ares_c_ares`** | [sha256:ddce8def076a](https://github.com/c-ares/c-ares/archive/7691f773af79bf75a62d1863fd0f13ebf9dc51b1.zip) |
| [http_archive](https://docs.bazel.build/versions/master/be/workspace.html#http_archive) | **`@boringssl`** | [(no hash provided)](https://boringssl.googlesource.com/boringssl/+archive/74ffd81aa7ec3d0aa3d3d820dbeda934958ca81a.tar.gz) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@libssl`** | `//external:libssl` (`@boringssl//:ssl`) |
| [new_http_archive](https://docs.bazel.build/versions/master/be/workspace.html#new_http_archive) | **`@com_github_madler_zlib`** | [sha256:1cce3828ec2b](https://github.com/madler/zlib/archive/cacf7f1d4e3d44d871b605da3b647f07d718623f.zip) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@cares`** | `//external:cares` (`@com_google_grpc//third_party/cares:ares`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@zlib`** | `//external:zlib` (`@com_github_madler_zlib//:zlib`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@nanopb`** | `//external:nanopb` (`@com_google_grpc//third_party/nanopb`) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protoc_gen_grpc_cpp`** | `//external:protoc_gen_grpc_cpp` (`@com_google_grpc//:grpc_cpp_plugin`) |
| [http_archive](https://docs.bazel.build/versions/master/be/workspace.html#http_archive) | **`@com_google_googletest`** | [sha256:f87029f64727](https://github.com/google/googletest/archive/7c6353d29a147cad1c904bf2957fd4ca2befe135.zip) |

## Java

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [http_file](https://docs.bazel.build/versions/master/be/workspace.html#http_file) | **`@protoc_gen_grpc_java_linux_x86_64`** | [sha256:4229579f6e2b](https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.6.1/protoc-gen-grpc-java-1.6.1-linux-x86_64.exe) |
| [http_file](https://docs.bazel.build/versions/master/be/workspace.html#http_file) | **`@protoc_gen_grpc_java_macosx`** | [sha256:9e3515e22e23](https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.6.1/protoc-gen-grpc-java-1.6.1-osx-x86_64.exe) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@junit_junit_4`** | [junit:junit:jar:4.12](http:repo1.maven.org/maven2/junit/junit/jar) (2973d1) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_api_grpc_proto_google_common_protos`** | [com.google.api.grpc:proto-google-common-protos:0.1.9](http:repo1.maven.org/maven2/com/google/api/grpc/proto-google-common-protos/0.1.9) (3760f6) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_code_findbugs_jsr305`** | [com.google.code.findbugs:jsr305:3.0.0](http:repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.0) (5871fb) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_code_gson_gson`** | [com.google.code.gson:gson:2.7](http:repo1.maven.org/maven2/com/google/code/gson/gson/2.7) (751f54) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_errorprone_error_prone_annotations`** | [com.google.errorprone:error_prone_annotations:2.0.11](http:repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.0.11) (3624d8) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_guava_guava`** | [com.google.guava:guava:19.0](http:repo1.maven.org/maven2/com/google/guava/guava/19.0) (6ce200) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_instrumentation_instrumentation_api`** | [com.google.instrumentation:instrumentation-api:0.4.3](http:repo1.maven.org/maven2/com/google/instrumentation/instrumentation-api/0.4.3) (41614a) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_protobuf_protobuf_java`** | [com.google.protobuf:protobuf-java:3.4.0](http:repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.4.0) (b32aba) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@com_google_protobuf_protobuf_java_util`** | [com.google.protobuf:protobuf-java-util:3.3.1](http:repo1.maven.org/maven2/com/google/protobuf/protobuf-java-util/3.3.1) (35d048) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_context`** | [io.grpc:grpc-context:1.6.1](http:repo1.maven.org/maven2/io/grpc/grpc-context/1.6.1) (9c52ae) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_core`** | [io.grpc:grpc-core:1.6.1](http:repo1.maven.org/maven2/io/grpc/grpc-core/1.6.1) (871c93) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_netty`** | [io.grpc:grpc-netty:1.6.1](http:repo1.maven.org/maven2/io/grpc/grpc-netty/1.6.1) (6941e4) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_protobuf`** | [io.grpc:grpc-protobuf:1.6.1](http:repo1.maven.org/maven2/io/grpc/grpc-protobuf/1.6.1) (a309df) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_protobuf_lite`** | [io.grpc:grpc-protobuf-lite:1.6.1](http:repo1.maven.org/maven2/io/grpc/grpc-protobuf-lite/1.6.1) (124bca) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_grpc_grpc_stub`** | [io.grpc:grpc-stub:1.6.1](http:repo1.maven.org/maven2/io/grpc/grpc-stub/1.6.1) (f32b7a) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_buffer`** | [io.netty:netty-buffer:4.1.14.Final](http:repo1.maven.org/maven2/io/netty/netty-buffer/4.1.14.Final) (71f0a7) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_codec`** | [io.netty:netty-codec:4.1.14.Final](http:repo1.maven.org/maven2/io/netty/netty-codec/4.1.14.Final) (b8573a) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_codec_http`** | [io.netty:netty-codec-http:4.1.14.Final](http:repo1.maven.org/maven2/io/netty/netty-codec-http/4.1.14.Final) (f287b5) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_codec_http2`** | [io.netty:netty-codec-http2:4.1.14.Final](http:repo1.maven.org/maven2/io/netty/netty-codec-http2/4.1.14.Final) (00d2af) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_codec_socks`** | [io.netty:netty-codec-socks:4.1.14.Final](http:repo1.maven.org/maven2/io/netty/netty-codec-socks/4.1.14.Final) (b8d856) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_common`** | [io.netty:netty-common:4.1.14.Final](http:repo1.maven.org/maven2/io/netty/netty-common/4.1.14.Final) (230ff0) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_handler`** | [io.netty:netty-handler:4.1.14.Final](http:repo1.maven.org/maven2/io/netty/netty-handler/4.1.14.Final) (626a48) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_handler_proxy`** | [io.netty:netty-handler-proxy:4.1.14.Final](http:repo1.maven.org/maven2/io/netty/netty-handler-proxy/4.1.14.Final) (9dbedd) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_resolver`** | [io.netty:netty-resolver:4.1.14.Final](http:repo1.maven.org/maven2/io/netty/netty-resolver/4.1.14.Final) (f91e01) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_netty_netty_transport`** | [io.netty:netty-transport:4.1.14.Final](http:repo1.maven.org/maven2/io/netty/netty-transport/4.1.14.Final) (3ed647) |
| [maven_jar](https://docs.bazel.build/versions/master/be/workspace.html#maven_jar) | **`@io_opencensus_opencensus_api`** | [io.opencensus:opencensus-api:0.5.1](http:repo1.maven.org/maven2/io/opencensus/opencensus-api/0.5.1) (cbd0a7) |

## C#

| Rule | Workspace | Detail |
| ---: | :--- | :--- |
| [new_nuget_package](https://github.com/bazelbuild/rules_dotnet#new_nuget_package) | **`@nuget_google_protobuf`** | [Google.Protobuf@3.4.0](https://www.nuget.org/packages/Google.Protobuf) |
| [new_nuget_package](https://github.com/bazelbuild/rules_dotnet#new_nuget_package) | **`@nuget_grpc`** | [Grpc@1.6.0](https://www.nuget.org/packages/Grpc) |
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protoc_gen_grpc_csharp`** | `//external:protoc_gen_grpc_csharp` (`@com_google_grpc//:grpc_csharp_plugin`) |

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
| [bind](https://docs.bazel.build/versions/master/be/workspace.html#bind) | **`@protoc_gen_grpc_node`** | `//external:protoc_gen_grpc_node` (`@com_google_grpc//:grpc_node_plugin`) |
| [npm_repository](https://github.com/pubref/rules_node#npm_repository) | **`@npm_protobuf_stack`** | [async@1.5.2](https://npmjs.org/package/async), [google-protobuf@3.1.1](https://npmjs.org/package/google-protobuf), [lodash@4.6.1](https://npmjs.org/package/lodash), [minimist@1.2.0](https://npmjs.org/package/minimist) |
| [npm_repository](https://github.com/pubref/rules_node#npm_repository) | **`@npm_grpc`** | [grpc@1.0.0](https://npmjs.org/package/grpc) |
