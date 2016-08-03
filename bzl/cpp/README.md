# `rules_protobuf_cpp`

## Usage

Load the `protoc_cpp` rule in your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "protoc_cpp")
```

### 1. Generate protobuf classes to `*.pb.cc` and `*.pb.h` outputs

```python
protoc_cpp(
  name = "proto",
  srcs = ["helloworld.proto"],

  # Default is false, so omit this if you are not using service
  # definitions in your .proto files
  with_grpc = True,
)
```

```sh
$ cd examples/helloworld/cpp
$ bazel build :proto
$ less $(bazel info bazel-genfiles)/examples/helloworld/cpp/helloworld.pb.h
$ less $(bazel info bazel-genfiles)/examples/helloworld/cpp/helloworld.pb.cc
```

### 2,3. Compile/run generated protobufs (+/- gRPC)

The generated files are in the `bazel-genfiles/` directory.  Include
the header file relative to the workspace root:

```c
#include "examples/helloworld/cpp/helloworld.grpc.pb.h"
```

```python
cc_binary(
    name = 'server',
    srcs = [
        'greeter_server.cc',
        ':proto',
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
