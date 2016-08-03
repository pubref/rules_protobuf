# `rules_protobuf_go`

## Rule `protoc_go` arguments

Includes all [common attributes][../protoc]:

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `gen_go` | `boolean` | Generate go sources | `True` |
| `gen_go_options` | `string_list` | Optional plugin arguments |  |
| `protoc_gen_go` | `executable` | The go protoc plugin binary | `@com_github_golang_protobuf//:protoc_gen_go` |

## Usage

Load the `protoc_go` rule in your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "protoc_go")
```

Bazel support for `go` is provided by
[rules_go](https://github.com/bazelbuild/rules_go) which is loaded by
this `WORKSPACE`.

### 1. Generate protobuf classes into a `*.pb.go` outputs

```python
protoc_go(
  name = "my_protobufs",
  srcs = ["my.proto"],

  # Default is false, so omit this if you are not using service
  # definitions in your .proto files
  with_grpc = True,
)
```

```sh
$ bazel build my_protobufs
$ less bazel-genfiles/.../my.proto.pb.go
```

### 2,3. Compile/run generated protobufs (+/- gRPC)

Compilation of the output `*.pb.go` files is a work-in-progress. See
https://github.com/pubref/rules_protobuf/issues/1.
