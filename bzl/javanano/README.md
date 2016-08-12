# Android Rules (JavaNano)

| Rule | Description |
| ---  | --- |
| `android_proto_library` | Generates and compiles protobuf source files. |
| `android_proto_compile` | Generates protobuf source files. |

## Installation

Enable java support by loading the set of java dependencies in your workspace.

```python
protobuf_dependencies(
  with_java=True,
  with_javanano=True,
  with_grpc=True,
)
```

## Usage of `android_proto_library`

Usage of `android_proto_library` is identical to
[java_proto_library][bzl/java].  If invoked in a BUILD file, this rule
generates [JavaNano][javanano] protocol buffers rather than standard ones.

[javanano]: https://github.com/google/protobuf/tree/master/javanano#nano-version
