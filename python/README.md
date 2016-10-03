# Python Rules

| Rule | Description |
| ---: | :--- |
| [py_proto_repositories](#py_proto_repositories) | Load workspace dependencies. |
| [py_proto_compile](#py_proto_compile) | Generate python protobuf source files. |

## python\_proto\_repositories

Enable python support by loading the dependencies in your workspace.

```python
load("@org_pubref_rules_protobuf//python:rules.bzl", "python_proto_repositories")
python_proto_repositories()
```

## py\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//python`.

```python
load("@org_pubref_rules_protobuf//python:rules.bzl", "python_proto_compile")

py_proto_compile(
  name = "protos",
  protos = ["message.proto"],
  with_grpc = True, # only one file is generated with or without grpc
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/message_pb2.py
```

## py\_proto\_library (not implemented)

Support for a library rule would be dependent on loading of pip
dependencies (this does not exist in bazel ecosystem at the moment).
