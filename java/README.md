# Java Rules

| Rule | Description |
| ---: | :--- |
| [java_proto_repositories](#java_proto_repositories) | Load WORKSPACE dependencies. |
| [java_proto_compile](#java_proto_compile) | Generate protobuf source files. |
| [java_proto_library](#java_proto_library) | Generate and compiles protobuf source files. |
| [java_proto_language_import](#java_proto_language_import) | Collect deps from a proto_language and expose them to dependent rules via java_import. |

## java\_proto\_repositores

Enable Java support by loading the dependencies in your workspace.

```python
load("@org_pubref_rules_protobuf//java:rules.bzl", "java_proto_repositories")
java_proto_repositories()
```

## java\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//:java`.

```python
load("@org_pubref_rules_protobuf//java:rules.bzl", "java_proto_compile")

java_proto_compile(
  name = "protos",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/protos.srcjar
```

## java\_proto\_library

Pass the set of protobuf source files to the `protos` attribute.
When depending on a java_proto_library target, it will automatically export
`@org_pubref_rules_protobuf//java:grpc_compiletime_deps` for you.

```python
load("@org_pubref_rules_protobuf//java:rules.bzl", "java_proto_library")

java_proto_library(
  name = "protolib",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protolib
Target //:protolib up-to-date:
  bazel-bin/protolib.jar
```

## java\_proto\_language\_import

When using the compiled library in other rules, you may need the
compile-time or runtime dependencies.  You can access these using the
`java_proto_language_import` rule.  There are several pre-defined ones
in the BUILD file in this directory.

```python
java_library(
  name = "mylib",
  srcs = ['MyApp.java'],
  deps = [
    ":protolib",
    "@org_pubref_rules_protobuf//java:grpc_compiletime_deps",
  ]
)
```

```python
java_binary(
  name = "myapp",
  main_class = "example.MyApp",
  runtime_deps = [
    ":mylib",
    "@org_pubref_rules_protobuf//java:netty_runtime_deps",
  ]
)
```

```sh
# Run your app
$ bazel run :myapp

# Build a self-contained executable jar
$ bazel build :myapp_deploy.jar
```

Consult source files in the
[examples/helloworld/java](../examples/helloworld/java) directory for
additional information.
