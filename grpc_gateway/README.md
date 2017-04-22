# Grpc-Gateway Rules

| Rule | Description |
| ---: | :--- |
| [grpc_gateway_proto_repositories](#grpc_gateway_proto_repositories) | Load WORKSPACE dependencies. |
| [grpc_gateway_proto_compile](#grpc_gateway_proto_compile) | Generate protobuf source files. |
| [grpc_gateway_proto_library](#grpc_gateway_proto_library) | Generate and compiles protobuf source files. |
| [grpc_gateway_swagger_compile](#grpc_gateway_swagger_compile) | Generate swwagger.json source files. |

## grpc_gateway\_proto\_repositories

Enable [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway)
support by loading the dependencies in your workspace.

> IMPORTANT: This should occur after loading
> [rules_go](https://github.com/bazelbuild/rules_go).

```python
load("@org_pubref_rules_protobuf//grpc_gateway:rules.bzl", "grpc_gateway_proto_repositories")
grpc_gateway_proto_repositories()
```

## grpc_gateway\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//grpc_gateway`.

```python
load("@org_pubref_rules_protobuf//grpc_gateway:rules.bzl", "grpc_gateway_proto_compile")

grpc_gateway_proto_compile(
  name = "protos",
  protos = ["message.proto"],
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/message.pb.gw.go
```

## grpc_gateway\_proto\_library

Pass the set of protobuf source files to the `protos` attribute.

```python
load("@org_pubref_rules_protobuf//grpc_gateway:rules.bzl", "grpc_gateway_proto_library")

grpc_gateway_proto_library(
  name = "protolib",
  protos = ["message.proto"],
)
```

```sh
$ bazel build :protolib
Target //:protolib up-to-date:
  bazel-bin/protolib.a
```

To get the list of required compile-time dependencies in other
contexts for grpc-related code, load the list from the rules.bzl file:

```python
load("@org_pubref_rules_protobuf//grpc_gateway:rules.bzl", "GRPC_COMPILE_DEPS")

go_binary(
  name = "gateway",
  srcs = ["main.go"],
  deps = [
    ":protolib"
  ] + GRPC_COMPILE_DEPS,
)
```

In this case `main.go` should implement the http entrypoint for the
grpc-gateway
[as described](https://github.com/grpc-ecosystem/grpc-gateway#usage).

This rule includes all common `_library` attributes in addition to:

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `log_level` | `int` | Logging threshold level. | `0` |
| `log_dir` | `string` | Log directory pathname. | `""` |
| `log_backtrace_at` | `int` | See grpc_gateway docs. | `0` |
| `logtostderr` | `boolean` | Emit logging to stderr instead of a log file. | `True` |
| `alsologtostderr` | `boolean` | Emit logging to stderr in addition to the log file. | `False` |
| `stderrthreshold` | `boolean` | Emit logging to stderr rather than a file. | `True` |
| `stderrthreshold` | `int` | See grpc_gateway docs. | `0` |
| `log_backtrace_at` | `int` | See grpc_gateway docs. | `0` |
| `request_context` | `boolean` | See grpc_gateway docs. | `False` |

## grpc_gateway_binary

The shortcut rule for the above is the `grpc_gateway_binary` rule:

```python
grpc_gateway_binary(
  name = "gateway",
  srcs = ["main.go"],
  protos = [message.proto],
)
```

## grpc_gateway_swagger_compile

The `grpc_gateway_swagger_compile` rule can be used to generate
`*.swagger.json` outputs:

```python
load("@org_pubref_rules_protobuf//grpc_gateway:rules.bzl", "grpc_gateway_swagger_compile")

grpc_gateway_swagger_compile(
  name = "swagger",
  protos = ["message.proto"],
)
```

```sh
$ bazel build :swagger
Target //:protos up-to-date:
  bazel-genfiles/message.swagger.json
```

Consult source files in the
[examples/helloworld/grpc_gateway](../examples/helloworld/grpc_gateway) directory for
additional information.


[grpc-gateway-home]:https://github.com/grpc-ecosystem/grpc-gateway
