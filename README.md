# `rules_protobuf`

---

This is a minimal repository that provides a skylark rule to build
protocol buffer libraries for (java, golang, ~~python~~,
~~javascript~~, ~~cpp~~) on (linux, macosx, ~~windows~~).  This
repository may become obsolete when protobuf generation is supported
natively by bazel itself.

| ![bazel](https://github.com/pubref/rules_protobuf/blob/master/bazel.png) | ![rules_protobuf](https://github.com/pubref/rules_protobuf/blob/master/rules_protobuf.png) | ![gRPC](https://github.com/pubref/rules_protobuf/blob/master/gRPC.png) |
| --- | --- | --- |
| Bazel | rules_protobuf | gRPC |

---

| Language | Support | Notes |
| -------- | ------- | ----- |
| java | yes | `protobuf-java 3.0.0` |
| go | in-progress |  |
| python | TODO |  |
| cpp | TODO |  |
| js | TODO |  |

---

# Requirements

These are build rules for [bazel][bazel-home].  If you have not already
installed `bazel` on your workstation, follow the
[bazel instructions][bazel-install].  Here's one way (osx):

```sh
$ curl -O -J -L https://github.com/bazelbuild/bazel/releases/download/0.3.1/bazel-0.3.1-installer-darwin-x86_64.sh
$ shasum -a256 bazel-0.3.1-installer-darwin-x86_64.sh
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
osx) and other required dependencies specific for a particular
language output.  You must specify which language(s) you'd like
support for:

```python
git_repository(
  name = "org_pubref_rules_protobuf",
  remote = "https://github.com/pubref/rules_protobuf",
  tag = "0.2.0",
  # Or, use the latest commit
  #commit = "bf8de4e05f77ad67bbdaaed4c88951ba5667ce34",
)

load("@org_pubref_rules_protobuf//bzl:rules.bzl", "rules_protobuf")

# Specify language modules to load
rules_protobuf(
  with_java = True,
  with_go = True,
)
```

For fine-grained control over the dependencies that `rules_protobuf`
loads, call the `rules_protobuf` macro and one of the language
specific modules with `omit_{dependency}` arguments.  For example:

```python
load(
  "@org_pubref_rules_protobuf//bzl:rules.bzl",
  "rules_protobuf",
  "rules_protobuf_java",
)

# Make the protoc binary available
rules_protobuf()

# Make the protoc-gen-grpc-java binary and all dependent jars available,
# but don't try to load guava.  Guava is still required, so this assumes you have a
# another workspace rule that provides com_google_guava_guava via another mechanism,
# possibly a local or alternate version.
rules_protobuf_java(
  omit_com_google_guava_guava = True,
)
```

Please refer to the
[bzl/{language}.bzl](https://github.com/pubref/rules_protobuf/tree/master/protobuf)
file for the set of external dependencies that will be hoisted into
your project.

# Java Usage

Load the `protoc_java` rule In your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "protoc_java")
```

Generate protobuf `*.java` source files, bundled into a
`my_proto.srcjar`:

```python
protoc_java(
  name = "my_protobufs",
  srcs = ["my.proto"],

  # Default is false, so omit this if you are not using service
  # definitions in your .proto files
  with_grpc = True,

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

If your `MyApp.java` has a `main` method, you can run it with
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

# Go Usage

 Usage of
`protoc_go` is similar to `proto_java`.  There is an additional

```python
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "protoc_java")
```

# Examples

- [helloworld](https://github.com/pubref/rules_protobuf/tree/go/examples/helloworld)

Demonstrative commands for running the helloworld client/server example (adapted
from
`https://github.com/grpc/grpc-java/blob/master/examples/src/main/proto/helloworld.proto`)
are found in the `examples/helloworld/Makefile`.

```sh
# In terminal 1:
$ (cd examples/helloworld && make netty_server)

# In terminal 2:
$ (cd examples/helloworld && make netty_client)
```

# Arguments to the `protoc` rule

The language specific rules such as `protoc_java` and `protoc_go` are
essentially convenience rules that call the `protoc` rule with the
`gen_{language}` attribute as `True`.  For full control over protocol
buffer generation in multiple languages, invoke the `protoc` rule
directly.

## `protoc` Arguments (common to all generating rules)

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `name` | `string` | The name of the rule. |(required) |
| `srcs` | `label_list` | List of protocol buffer source file(s) | (required) |
| `imports` | `string_list` | List of `--import` that will be passed to `protoc` directly | `[]` |
| `with_grpc` | `boolean` | If `True`, additional `protoc` arguments will be assembled for the language-specific protoc plugins. | `False`
| `verbose` | If true, additional debugging output will be printed. | `False` |
| `protoc` | `executable` | The `protoc` binary | `//third_party/protoc:protoc_bin` |

## `protoc_java` Arguments

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `gen_java` | `boolean` | Generate java sources (bundled in a `{name}.srcjar` file | `False` |
| `gen_java_options` | `string_list` | Optional plugin arguments |  |
| `protoc_gen_grpc_java` | `executable` | The java plugin `plugin` binary | `//third_party/protobuf:protoc_gen_grpc_java` |

## `protoc_go` Arguments

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `gen_go` | `boolean` | Generate go sources (each input file generates a corresponding `{basename}.pb.go` file | `False` |
| `gen_go_options` | `string_list` | Optional plugin arguments |  |
| `protoc_gen_grpc_java` | `executable` | The java plugin `plugin` binary | `//third_party/protobuf:protoc_gen_grpc_java` |
| `protoc_gen_go` | `executable` | The go plugin `plugin` binary | `//third_party/protobuf:protoc_gen_go` |

# Contributing

Contributions welcome; please create Issues or GitHub pull requests.

# Credits

* [@yugui][yugui]: Primary source for the go support from [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway/blob/e958c5db30f7b99e1870db42dd5624322f112d0c/examples/bzl/BUILD).

* [@mzhaom][mzhaom]: Primary source for the skylark rule (from
  <https://github.com/mzhaom/trunk/blob/master/third_party/grpc/grpc_proto.bzl>).

* [@jart][jart]: Overall repository structure and bazel code layout
  (based on [rules_closure]).

* Much thanks to all the members of the bazel, protobuf, and gRPC teams.

---

[yugui]: http://github.com/yugui "Yuki Yugui Sonoda"
[jart]: http://github.com/jart "Justine Tunney"
[mzhaom]: http://github.com/mzhaom "Ming Zhao"
[bazel-home]: http://bazel.io "Bazel Homepage"
[bazel-install]: http://bazel.io/docs/install.html "Bazel Installation"
[rules_closure]: http://github.com/bazelbuild/rules_closure "Rules Closure"
[rules_go]: http://github.com/bazelbuild/rules_go "Rules Go"
