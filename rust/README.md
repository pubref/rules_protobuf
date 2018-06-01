# Rust Rules

| Rule                                                | Description                                  |
| --------------------------------------------------: | :------------------------------------------- |
| [rust_proto_repositories](#rust_proto_repositories) | Load WORKSPACE dependencies.                 |
| [rust_proto_compile](#rust_proto_compile)           | Generate protobuf source files.              |
| [rust_proto_library](#rust_proto_library)           | Generate and compiles protobuf source files. |

## rust\_proto\_repositories

Enable Rust support by loading the dependencies in your workspace.

```python
http_repository(
    name = "io_bazel_rules_rust",
    urls = ["https://github.com/bazelbuild/rules_rust/archive/af9821bf3378b525ec3db0af3b1ca388920a8fb0.tar.gz"],
    strip_prefix = "rules_rust-af9821bf3378b525ec3db0af3b1ca388920a8fb0",
    sha256 = "3c53a5ead9db93460a03a85cd28ec5579f608a0bd044b7d767b1dfa85023ad78",
)

load("@io_bazel_rules_rust//rust:repositories.bzl", "rust_repositories")
rust_repositories()
load("@org_pubref_rules_protobuf//rust:rules.bzl", "rust_proto_repositories")
rust_proto_repositories()
```

## rust\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//rust`.

```python
load("@org_pubref_rules_protobuf//rust:rules.bzl", "rust_proto_compile")

rust_proto_compile(
  name = "protos",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/protos.rs
```

## rust\_proto\_library

Pass the set of protobuf source files to the `protos` attribute.

```python
load("@org_pubref_rules_protobuf//rust:rules.bzl", "rust_proto_library")

rust_proto_library(
  name = "helloworld",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :helloworld
Target //:helloworld up-to-date:
  bazel-bin/libhelloworld--2112777365.rlib
```

To get the list of required compile-time dependencies in other contexts for grpc-related code, load the list from the rules.bzl file:

```python
load("@org_pubref_rules_protobuf//rust:rules.bzl", "GRPC_COMPILE_DEPS")

rust_library(
  name = "mylib",
  srcs = ['mylib.rs'],
  deps = [
    ":protolib"
  ] + GRPC_COMPILE_DEPS,
)
```

Consult source files in the [examples/helloworld/rust](../examples/helloworld/rust) directory for additional information.
