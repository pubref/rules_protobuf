# Java Rules

| Rule | Description |
| ---  | --- |
| `java_proto_library` | Generates and compiles protobuf source files. |
| `java_proto_compile` | Generates protobuf source files. |

## Installation

Enable java support by loading the set of java dependencies in your workspace.

```python
protobuf_dependencies(
  with_java=True,
)
```

## Usage of `java_proto_library`

Load the rule in your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:java/rules.bzl", "java_proto_library")
```

Invoke the rule.  Pass the set of protobuf source files to the
`protos` attribute.

```python
java_proto_library(
  name = "protolib",
  protos = ["my.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protolib
```

When using the compiled library in other rules, you'll likely need the
compile-time or runtime dependencies.  You can access that list on the
class descriptor:


```python
load("@org_pubref_rules_protobuf//bzl:java/class.bzl", JAVA = "CLASS")
```

```python
java_library(
  name = "mylib",
  srcs = ['MyApp.java'],
  deps = [
    ":protolib"
  ] + JAVA.grpc.compile_deps,
)
```

One could also specify all the sources needed in the
`java_proto_library` itself:


```python
java_proto_library(
  name = "mylib",
  protos = ["my.proto"],
  srcs = ['MyApp.java'],
  with_grpc = True,
)
```

When using runnable gRPC related code in a `java_binary` or
`java_test`, you'll likely need the additional netty-related runtime
dependencies as well.


```python
java_binary(
  name = "myapp",
  main_class = "example.MyApp",
  runtime_deps = [
    ":mylib"
  ] + JAVA.grpc.netty_runtime_deps,
)
```

```sh
# Run your app
$ bazel run :myapp

# Build a self-contained executable jar
$ bazel build :myapp_deploy.jar
```

Consult source files in the `examples/helloworld/java/` directory for additional information.
