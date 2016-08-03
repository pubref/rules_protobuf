# `rules_protobuf_cpp`

## Usage

Load the `protoc_cpp` rule in your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "protoc_cpp")
```

### 1. Generate protobuf classes into a `*.pb.cpp` outputs

```python
protoc_cpp(
  name = "my_protobufs",
  srcs = ["my.proto"],

  # Default is false, so omit this if you are not using service
  # definitions in your .proto files
  with_grpc = True,
)
```

```sh
$ bazel build my_protobufs
$ less bazel-genfiles/.../my.proto.pb.h
$ less bazel-genfiles/.../my.proto.pb.cc
```

### 2,3. Compile/run generated protobufs (+/- gRPC)

Compilation of the output `*.pb.cc` files is not yet implemented.
