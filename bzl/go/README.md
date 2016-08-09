# `go_proto_library`

## Usage


### Load dependencies for golang support in your `WORKSPACE` by
    setting the `go=True` flag:

```python
load("@org_pubref_rules_protobuf//bzl:protobuf.bzl", "protobuf_repositories")
protobuf_repositories(
  go = True,
  with_grpc = True,
)
```


### Load the `go_proto_library` rule in your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:go/rules.bzl", "go_proto_library")
```

Note: this rule internally calls the `go_library` rule provided by
[rules_go](https://github.com/bazelbuild/rules_go).


### Generate and compile `*.pb.go` outputs.

```python
go_proto_library(
  name = "proto",
  srcs = ["helloworld.proto"],

  # Default is false, so omit this if you are not using service
  # definitions in your .proto files
  with_grpc = True,
)
```

```sh
$ bazel build examples/helloworld/protos:golib

# fyi: The "_pb" implicit build target yields the generated *.pb.go files:
$ bazel build examples/helloworld/protos:golib_pb
```


### Compile and run the gRPC server

```python
load("@io_bazel_rules_go//go:def.bzl", "go_binary")

go_binary(
    name = "server",
    srcs = [
        "main.go",
    ],
    deps = [
        "//examples/helloworld/proto:golib",
        "@com_github_golang_glog//:go_default_library",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//:context",
    ],
)
```

```sh
$ bazel build examples/helloworld/go/server

# The run command will block until shutdown, preventing any other
  bazel commands.  Better to invoke the server binary from the shell
  directly.  This executable file can be copied to a location in your
  PATH if desired.

# bazel run examples/helloworld/go/server
$ bazel-bin/examples/helloworld/go/server/server
```


### Compile and run the gRPC client

```python
load("@io_bazel_rules_go//go:def.bzl", "go_binary")

go_binary(
    name = "client",
    srcs = [
        "main.go",
    ],
    deps = [
        "//examples/helloworld/proto:golib",
        "@com_github_golang_glog//:go_default_library",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//:context",
    ],
)
```

```sh
$ bazel build examples/helloworld/go/client
$ bazel   run examples/helloworld/go/client
$ bazel-bin/examples/helloworld/go/client/client
```
