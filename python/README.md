# Python Rules

| Rule | Description |
| ---: | :--- |
| [py_proto_compile](#py_proto_compile) | Generate python protobuf source files. |

## py\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//python`.

```python
load("@org_pubref_rules_protobuf//python:rules.bzl", "python_proto_compile")

py_proto_compile(
  name = "protos",
  protos = ["message.proto"],
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/message_pb2.py
```

Support for a library rule is dependent on loading the workspace
dependencies for the py_library rule which has not been implemented
yet.
