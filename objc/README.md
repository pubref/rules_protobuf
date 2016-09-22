# Objective-C Rules

*Objective-C rules have not been adequately tested.  They may or may
 not work for you.*

| Rule | Description |
| ---: | :--- |
| [objc_proto_repositories](#objc_proto_repositories) | Load WORKSPACE dependencies. |
| [objc_proto_compile](#objc_proto_compile) | Generate protobuf source files. |
| [objc_proto_library](#objc_proto_library) | Generate and compiles protobuf source files. |

## objc\_proto\_repositores

Enable support by loading the dependencies in your workspace.

```python
load("@org_pubref_rules_protobuf//objc:rules.bzl", "objc_proto_repositories")
objc_proto_repositories()
```

## objc\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//objc`.

```python
load("@org_pubref_rules_protobuf//objc:rules.bzl", "objc_proto_compile")

objc_proto_compile(
  name = "protos",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/message.pbobjc.h
  bazel-genfiles/message.pbobjc.m
```

## objc\_proto\_library

Pass the set of protobuf source files to the `protos` attribute.

```python
load("@org_pubref_rules_protobuf//objc:rules.bzl", "objc_proto_library")

objc_proto_library(
  name = "protolib",
  protos = ["message.proto"],
  with_grpc = False, # not yet implemented
)
```

```sh
$ bazel build :protolib
Target //:protolib up-to-date:
  bazel-bin/protolib.m
```
