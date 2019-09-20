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
