# gRPC-gateway Rules

| Rule | Description |
| ---  | --- |
| `grpc_gateway_proto_compile` | Generates protobuf source files. |
| `grpc_gateway_proto_library` | Generates and compiles protobuf source files. |
| `grpc_gateway_binary` | Generates everything into a gateway binary. |

## Installation

Enable [grpc-gateway][grpc-gateway-home] support by loading the set of
dependencies in your workspace.

```python
protobuf_repositories(
  with_grpc_gateway=True,
)
```

## Usage of `grpc_gateway_proto_library`

Load the rule in your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:grpc_gateway/rules.bzl", "grpc_gateway_proto_library")
```

Invoke the rule.  Pass the set of protobuf source files to the
`protos` attribute.  These should be annotated with service options as
decribed in the
[grpc-gateway usage section home](https://github.com/grpc-ecosystem/grpc-gateway#usage):

```python
grpc_gateway_proto_library(
  name = "gw",
  protos = ["my.proto"],
)
```

```sh
$ bazel build :gw
```

For other rules that use gRPC or protobuf related classes, you can
access the list of dependencies on the language descriptor:


```python
load("@org_pubref_rules_protobuf//bzl:grpc_gateway/class.bzl", GRPC_GATEWAY = "CLASS")
```

```python
go_binary(
  name = "mygateway",
  srcs = ["main.go"],
  deps = [
    ":gw"
  ] + GRPC_GATEWAY.grpc.compile_deps,
)
```


In this case `main.go` should implement the http entrypoint for the
grpc-gateway
[as described](https://github.com/grpc-ecosystem/grpc-gateway#usage).

Consult source files in the `examples/helloworld/grpc-gateway/`
directory for additional information.

The shortcut rule for this is the `grpc_gateway_binary` rule:

```python
grpc_gateway_binary(
  name = "mygateway",
  srcs = ["main.go"],
  protos = [my.proto],
)
```

[grpc-gateway-home]:https://github.com/grpc-ecosystem/grpc-gateway


# `grpc_gateway_proto_compile` attributes`

The grpc_gateway rules include all common attributes in addition to go rule attributes in addition to:

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
