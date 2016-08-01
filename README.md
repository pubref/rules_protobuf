# `rules_protobuf`

This is a minimal repository that provides a skylark rule to build
protocol buffer libraries (currently java only).  This repository will
become obsolete when protobuf generation is supported natively by
bazel itself.

| ![bazel](https://github.com/pubref/rules_protobuf/blob/master/bazel.png) | ![rules_protobuf](https://github.com/pubref/rules_protobuf/blob/master/rules_protobuf.png) | ![gRPC](https://github.com/pubref/rules_protobuf/blob/master/gRPC.png) |
| --- | --- | --- |
| Bazel | rules_protobuf | gRPC |

---

# Requirements

These are build rules for [bazel][bazel-home].  If you have not already
installed `bazel` on your workstation, follow the
[bazel instructions][bazel-install].  Here's one way (osx):

```sh
$ curl -O -J -L https://github.com/bazelbuild/bazel/releases/download/0.3.1/bazel-0.3.1-installer-darwin-x86_64.sh
$ shasum -a265 bazel-0.3.1-installer-darwin-x86_64.sh
8d035de9c137bde4f709e3666271af01d1ef6bed6921e1a676d6a6dc0186395c  bazel-0.3.1-installer-darwin-x86_64.sh
$ chmod +x bazel-0.3.1-installer-darwin-x86_64.sh
$ ./bazel-0.3.1-installer-darwin-x86_64.sh
$ bazel version
Build label: 0.3.1
...
```

# Installation

Require these rules your `WORKSPACE` and trigger loading of external
dependencies (including the `protoc` prebuilt binaries for linux or
osx, the `protoc-gen-grpc-plugin` prebuilt binary, and a number of
compile dependencies such as `com.google.protobuf.*`, `io.grpc.*` as
well as related runtime dependencies such as `io.netty.*`):

```python
git_repository(
  name = "rules_protobuf",
  remote = "https://github.com/pubref/rules_protobuf",
  tag = "0.1.1",
  # Or, use the latest commit
  #commit = "bf8de4e05f77ad67bbdaaed4c88951ba5667ce34",
)

load("@rules_protobuf//protobuf:rules.bzl", "protobuf_dependencies")

protobuf_dependencies()
```

If you have already declared an external dependency jar in your
`WORKSPACE` that conflicts with one declared by `protobuf_repos()`,
you may selectively omit them from the load:

```python
load("@rules_protobuf//protobuf:rules.bzl", "protobuf_dependencies")
protobuf_dependencies(
  omit_com_google_guava_guava = True,
)
```

Please refer to the [protobuf/dependencies.bzl](https://github.com/pubref/rules_protobuf/blob/master/protobuf/dependencies.bzl) file for a list of
external dependencies that will be hoisted into your project.

# Usage

Load the `protobuf_java_library` rule In your `BUILD` file:

```python
load("@rules_protobuf//protobuf:rules.bzl", "protobuf_java_library")
```

Generate protobuf `*.java` source files, bundled into a
`my_proto.srcjar`:

```python
protobuf_java_library(
  name = "my_protobufs",
  src = "my.proto",

  # Default is false, so omit this if you are not using service
  # definitions in your .proto files
  use_grpc_plugin = True,

)
```

```sh
$ bazel build my_protobufs
```

And then depend on the protobuf rule in a java_library rule (for
example).  Remember that the srcjar contains java source code and not
compiled classfiles, so the protobuf rule label goes in the `srcs`
attribute and not the `deps` attribute (easy to do, not so easy to
recognize):

```python
java_library(
  name = "my_app",
  srcs = [
    "MyApp.java",
    ":my_protobufs",
  ],
  deps = [
    # Compile-time dependency for your standard protobufs
    "@com_google_protobuf_protobuf_java//jar",
    # Additional compile-time dependencies if grpc is used.
    "@com_google_guava_guava//jar",
    "@io_grpc_grpc_core//jar",
    "@io_grpc_grpc_protobuf//jar",
    "@io_grpc_grpc_stub//jar",
  ]
)
```

```sh
$ bazel build my_app
```

If your `MyClass.java` has a `main` method, you can run it with
something like:

```python
java_binary(
  name = "my_app_bin",
  main_class = "com.example.MyApp",
  runtime_deps = [
    ":my_app"

    # Additional runtime dependencies when using
    # netty as the grpc http2 provider.  If you're not using grpc,
    # these deps are not needed.
    "@io_grpc_grpc_netty//jar",
    "@io_grpc_grpc_protobuf_lite//jar",
    "@io_netty_netty_buffer//jar",
    "@io_netty_netty_codec//jar",
    "@io_netty_netty_codec_http2//jar",
    "@io_netty_netty_common//jar",
    "@io_netty_netty_handler//jar",
    "@io_netty_netty_resolver//jar",
    "@io_netty_netty_transport//jar",

  ]
)
```

```sh
$ bazel run my_app_bin
```

For the win, to create an executable jar with all runtime dependencies
packaged together in a single executable jar that can be deployed
anywhere, invoke the `{rule_name}_deploy.jar` *implicit build rule*:


```sh
$ bazel build my_app_bin_deploy.jar
$ cp bazel-bin/java/org/example/myapp/my_app_bin_deploy.jar /tmp
$ java -jar /tmp/my_app_bin_deploy.jar
```

# Examples

- [helloworld](https://github.com/pubref/rules_protobuf/tree/master/java/org/pubref/tools/bazel/protobuf/examples/helloworld)

Commands for running the helloworld client/server example (adapted
from
`https://github.com/grpc/grpc-java/blob/master/examples/src/main/proto/helloworld.proto`)
are found in the `Makefile`.  Note that `make` is not used by bazel or
this project other than to demonstrate those commands:

```sh
# In terminal 1:
$ make helloworld_server

# In terminal 2:
$ make helloworld_client
```

# Arguments to `protobuf_java_library`

| Name | Description | Default |
| ---- | ------- | ----------- |
| `name` | The name of the rule. |(required) |
| `src` | The name of the protocol buffer source file.  This is a single file, so each *.proto file will need its own rule | (required) |
| `use_grpc_plugin` | If true, additional `protoc` arguments will be assembled to run the `protoc-gen-grpc-java plugin` | `False` |
| `verbose` | If true, additional debugging output will be printed. | `False` |
| `_protoc` | For substitution of a different `protoc` binary | `//third_party/protobuf:protoc_bin` |
| `_protoc_gen_grpc_java` | For substitution of a different `plugin` binary | `//third_party/protobuf:protoc_gen_grpc_java` |

# Contributing

Contributions welcome; please create Issues or GitHub pull requests.

# Credits

* [@mzhaom][mzhaom]: Primary source for the skylark rule (from
  <https://github.com/mzhaom/trunk/blob/master/third_party/grpc/grpc_proto.bzl>).

* [@jart][jart]: Overall repository structure and bazel code layout
  (based on [rules_closure]).

* Much thanks to all the members of the bazel, protobuf, and gRPC teams.

[jart]: http://github.com/jart "Justine Tunney"
[mzhaom]: http://github.com/mzhaom "Ming Zhao"
[bazel-home]: http://bazel.io "Bazel Homepage"
[bazel-install]: http://bazel.io/docs/install.html "Bazel Installation"
[rules_closure]: http://github.com/bazelbuild/rules_closure "Rules Closure"
