# NodeJs Rules

| Rule | Description |
| ---: | :--- |
| [node_proto_repositories](#node_proto_repositories) | Load workspace dependencies. |
| [node_proto_compile](#node_proto_compile) | Generate node js protobuf source files. |

## node\_proto\_repositories

Enable node support by loading the dependencies in your workspace.

> IMPORTANT: This should occur after loading
> [rules_node](https://github.com/pubref/rules_node).

```python
load("@org_pubref_rules_protobuf//node:rules.bzl", "node_proto_repositories")
node_proto_repositories()
```

## node\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//node` (common js output of the `--js_out`
protoc option.

```python
load("@org_pubref_rules_protobuf//node:rules.bzl", "node_proto_compile")

node_proto_compile(
  name = "protos",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/message_pb.js
  bazel-genfiles/message_grpc_pb.js
```
