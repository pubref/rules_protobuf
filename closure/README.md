# Closure Javascript Rules

| Rule | Description |
| ---: | :--- |
| [closure_proto_repositories](#closure_proto_repositories) | Load WORKSPACE dependencies. |
| [closure_proto_compile](#closure_proto_compile) | Generate closure js protobuf source files. |
| [closure_proto_library](#closure_proto_library) | Generate and compiles closure js source files. |

## closure\_proto\_repositories

Enable closure support by loading the dependencies in your workspace.

> IMPORTANT: Closure rules require
> [rules_closure](https://github.com/bazelbuild/rules_closure).

```python
load("@org_pubref_rules_protobuf//closure:rules.bzl", "closure_proto_repositories")
closure_proto_repositories()
```

## closure\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//closure`.

```python
load("@org_pubref_rules_protobuf//closure:rules.bzl", "closure_proto_compile")

closure_proto_compile(
  name = "protos",
  protos = ["message.proto"],
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/message.js
```

## closure\_proto\_library

Pass the set of protobuf source files to the `protos` attribute.

```python
load("@org_pubref_rules_protobuf//closure:rules.bzl", "closure_proto_library")

closure_proto_library(
  name = "protolib",
  protos = ["message.proto"],
)
```

```sh
$ bazel build :Helloworld
Target //:Helloworld up-to-date:
  bazel-bin/protolib.js
```

---

Note that `closure_js_proto_library` is implemented in
[rules_closure](https://github.com/bazelbuild/rules_closure#closure_js_proto_library).
This rule is definitely a viable option but does not at the time of
this writing support imports or proto::proto dependencies.
