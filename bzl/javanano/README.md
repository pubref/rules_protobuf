# Android Rules (JavaNano)

| Rule | Description |
| ---  | --- |
| `android_proto_library` | Generates and compiles protobuf source files. |
| `android_proto_compile` | Generates protobuf source files. |

## Installation

Enable java support by loading the set of java dependencies in your workspace.

```python
protobuf_repositories(
  with_java=True,
  with_javanano=True,
  with_grpc=True,
)
```

## Usage of `android_proto_library`

Usage of `android_proto_library` is identical to
`java_proto_library`.  If invoked in a BUILD file, this rule
generates [JavaNano][javanano] protocol buffers rather than standard ones.


When using the compiled library in other rules, you'll likely need the
compile-time dependencies.  You can access that list on the class
descriptor:

```python
load("@org_pubref_rules_protobuf//bzl:javanano/class.bzl", NANO = "CLASS")
```

```python
android_library(
  name = "mylib",
  srcs = ['MyApp.java'],
  deps = [
    ":protolib"
  ] + NANO.grpc.compile_deps,
)
```

[javanano]: https://github.com/google/protobuf/tree/master/javanano#nano-version
