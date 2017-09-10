# Python Rules

| Rule | Description |
| ---: | :--- |
| [py_proto_repositories](#py_proto_repositories) | Load workspace dependencies. |
| [py_proto_compile](#py_proto_compile) | Generate python protobuf source files. |
| [py_proto_library](#py_proto_library) | Generate and compiles protobuf source files. |

## py\_proto\_repositories

1. Enable python support by loading the dependencies in your workspace:

```python
load("@org_pubref_rules_protobuf//python:rules.bzl", "py_proto_repositories")
py_proto_repositories()
```

## py\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//python`.

```python
load("@org_pubref_rules_protobuf//python:rules.bzl", "py_proto_compile")

py_proto_compile(
  name = "protos",
  protos = ["message.proto"],
  with_grpc = True, # only one file is generated with or without grpc
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/message_pb2.py
```

## py\_proto\_library

Pass the set of protobuf source files to the `protos` attribute.

```python
load("@org_pubref_rules_protobuf//python:rules.bzl", "py_proto_library")

py_proto_library(
  name = "protolib",
  protos = ["message.proto"],
  with_grpc = True,
)
```

# Runtime gRPC support

The instructions above demonstrate how to compile python sources for
protocol buffer +/- gRPC support.  For runtime grpc support in a
`py_binary` rule, the
[grpcio](https://pypi.python.org/pypi/grpcio/1.6.0) pypi package is
required.  You can have bazel include this as follows using
[rules_python](https://github.com/bazelbuild/rules_python).

## Step 1: Install rules_python and pip requirements in your WORKSPACE

```python
# 1-A. Pull down rules_python
http_archive(
    name = "io_bazel_rules_python",
    rule: "http_archive",
    url: "https://github.com/bazelbuild/rules_python/archive/07fba0f91bb5898d19daeaabf635d08059f7eacd.zip",
    sha256: "53fecb9ddc5d3780006511c9904ed09c15a8aed0644914960db89f56b1e875bd",
    strip_prefix: "rules_python-07fba0f91bb5898d19daeaabf635d08059f7eacd",
)

# 1-B. Load the skylark file containing the needed functions
load("@io_bazel_rules_python//python:pip.bzl", "pip_repositories", "pip_import")

# 1-C. Invoke pip_repositories to load rules_python internal dependencies
pip_repositories()

# 1-D. Invoke pip_import with the necessary python requirements.  You can refer to the
# one in rules_protobuf, or roll your own (make sure it includes 'grpcio==1.6.0' (or later)).
pip_import(
   name = "pip_grpcio",
   requirements = "@org_pubref_rules_protobuf//python:requirements.txt",
)

# 1-E. Load the requirements.bzl file that will be written in this new workspace
# defined in 1-D.
load("@pip_grpcio//:requirements.bzl", pip_grpcio_install = "pip_install")

# 1-F. Invoke this new function to trigger pypi install of 'grpcio' when needed.
pip_grpcio_install()
```


## Step 2: Include the grpcio package the py_binary rule for your gRPC client/server

```python
# Load the 'packages' function from the 'pip_grpcio' workspace
load("@pip_grpcio//:requirements.bzl", "packages")

# Define a py_binary rule and include the grpcio package as a dependency.
py_binary(
    name = "my_grpc_server",
    srcs = [
        "server.py",
    ],
    deps = [
        ":protolib", # a py_proto_library rule
        packages("grpcio"), # grpcio pypi package
    ],
)
```
