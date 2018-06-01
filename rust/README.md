# Rust Rules

| Rule                                                | Description                                  |
| --------------------------------------------------: | :------------------------------------------- |
| [rust_proto_repositories](#rust_proto_repositories) | Load WORKSPACE dependencies.                 |
| [rust_proto_compile](#rust_proto_compile)           | Generate protobuf source files.              |
| [rust_proto_library](#rust_proto_library)           | Generate and compiles protobuf source files. |

## rust\_proto\_repositories

Enable Rust support by loading the dependencies in your workspace.

> IMPORTANT: Rust currently requires a custom branch of [rules_rust](https://github.com/bazelbuild/rules_rust) having
> support for Rust 1.26.

```python
http_repository(
    name = "io_bazel_rules_rust",
    urls = ["https://github.com/damienmg/rules_rust/archive/67503c5bff487136d12fc530e3760ac7b31d330b.tar.gz"],
    strip_prefix = "rules_rust-67503c5bff487136d12fc530e3760ac7b31d330b",
    sha256 = "6725a05ab1aac5aecb8ab20d1d86af30818bf8e657ee80ea2eba57bf73f6d676",
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
