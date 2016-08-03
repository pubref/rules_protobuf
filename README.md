# `rules_protobuf`

---

Bazel skylark rules for generating protocol buffers in (java, golang)
 on (linux, macosx).

| ![Bazel][bazel_image] | ![Protobuf][rules_protobuf_image] | ![gRPC][grpc_image] |
| --- | --- | --- |
Bazel | rules_protobuf | gRPC |

---


| Language                 | Status | gRPC | Notes
| ------------------------ | ------ | ---- | -----
| [Java](bzl/java)         | alpha  | yes  |
| [Go](bzl/go)             |     1  |  no  |
| [Python](bzl/python)     |     1  |  no  |
| [Javascript](bzl/js)     |        |      |
| [C++](bzl/cpp)           |        |      |
| [JavaNano](bzl/javanano) |        |      |
| [Objective-C](bzl/objc)  |        |      |
| [C#](bzl/csharp)         |        |      |
| [Ruby](bzl/ruby)         |        |      |

1: Limited experimental support exists on separate branch.

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

[bazel_image]: https://github.com/pubref/rules_protobuf/blob/master/bazel.png
[rules_protobuf_image]: https://github.com/pubref/rules_protobuf/blob/master/rules_protobuf.png
[grpc_image]: https://github.com/pubref/rules_protobuf/blob/master/gRPC.png
