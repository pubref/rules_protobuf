# Ruby Rules

| Rule | Description |
| ---: | :--- |
| [ruby_proto_compile](#ruby_proto_compile) | Generate ruby protobuf source files. |

## ruby\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//ruby`.

```python
load("@org_pubref_rules_protobuf//ruby:rules.bzl", "ruby_proto_compile")

ruby_proto_compile(
  name = "protos",
  protos = ["message.proto"],
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/message_pb.rb
```
