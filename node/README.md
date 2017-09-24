# NodeJs Rules

| Rule | Description |
| ---: | :--- |
| [node_proto_repositories](#node_proto_repositories) | Load workspace dependencies. |
| [node_proto_compile](#node_proto_compile) | Generate node js protobuf source files. |
| [node_proto_library](#node_proto_library) | Generate a node module packaged with protobuf sources. |

## node\_proto\_repositories

Enable node support by loading the dependencies in your workspace.

> This should occur after loading
> [rules_node](https://github.com/pubref/rules_node).  See the
> `WORKSPACE` file for the appropriate commit to use from that repo.

```python
load("@org_pubref_rules_protobuf//node:rules.bzl", "node_proto_repositories")
node_proto_repositories()
```

## node\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//node` (common js output of the `--js_out`
protoc option.

```python
load("@org_pubref_rules_protobuf//node:rules.bzl", "node_proto_compile")

node_proto_compile(
  name = "protos",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/message_pb.js
  bazel-genfiles/message_grpc_pb.js
```


## node\_proto\_library

Load the requisite external node modules via the `yarn_modules` repository rule in your `WORKSPACE`:

```python
# WORKSPACE
load("@org_pubref_rules_node//node:rules.bzl", "yarn_modules")

yarn_modules(
    name = "yarn_modules",
    deps = {
        "google-protobuf": "3.4.0",
        "grpc": "1.6.0"
    },
)
```

Then, in your `BUILD` file:

```python
load("@org_pubref_rules_node//node:rules.bzl", "node_binary")
load("//node:rules.bzl", "node_proto_library")

node_proto_library(
    name = "api",
    protos = ["api.proto"],
    verbose = 0,
    with_grpc = True,
)

node_binary(
    name = "server",
    main = "server.js",
    deps = [
        ":api",
        "@yarn_modules//:_all_",
    ],
)
```
