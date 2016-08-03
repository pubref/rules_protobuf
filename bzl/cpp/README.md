# `rules_protobuf_cpp`

## Usage

Require dependencies in your `WORKSPACE` file:

```python
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "rules_protobuf_cpp")
rules_protobuf_cpp()
```

Load the `protoc_cpp` rule in your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "protoc_cpp")
```

### 1. Generate protobuf classes to `*.pb.cc` and `*.pb.h` outputs

```python
protoc_cpp(
  name = "protos",
  srcs = ["//examples/helloworld/proto:srcs"],
  with_grpc = True,
)
```

```sh
$ cd examples/helloworld/cpp
$ bazel build :protos
$ less $(bazel info bazel-genfiles)/examples/helloworld/cpp/helloworld.pb.h
$ less $(bazel info bazel-genfiles)/examples/helloworld/cpp/helloworld.pb.cc
$ less $(bazel info bazel-genfiles)/examples/helloworld/cpp/helloworld.grpc.pb.h
$ less $(bazel info bazel-genfiles)/examples/helloworld/cpp/helloworld.grpc.pb.cc
```

### 2,3. Compile/run generated protobufs (+/- gRPC)

Include the header file relative to the workspace root:

```c
#include "examples/helloworld/cpp/helloworld.grpc.pb.h"
```

```python
cc_binary(
    name = 'server',
    srcs = [
        'greeter_server.cc',
        ':protos',
    ],
    deps = [
        '@com_github_grpc_grpc//:grpc++',
    ],
    linkopts = ['-ldl'],
)
```


```sh
$ bazel run :server
...
Server listening on 0.0.0.0:50051
```

```sh
$ bazel run :client
...
Greeter received: Hello world
```
