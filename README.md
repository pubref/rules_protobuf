# `rules_protobuf` (αlpha) [![Build Status](https://travis-ci.org/pubref/rules_protobuf.svg?branch=master)](https://travis-ci.org/pubref/rules_protobuf)

---

Bazel skylark rules for building [protocol buffers][protobuf-home] on (macosx, linux).

| ![Bazel][bazel_image] | ![Protobuf][wtfcat_image] | ![gRPC][grpc_image] |
| --- | --- | --- |
Bazel | rules_protobuf | gRPC |

---

| Language                 | Compile (1) | Build (2) | gRPC (3) |
| ------------------------ | ------------ | ----------- | -------- |
| [C++][cpp]           | [cc_proto_compile][cpp] | [cc_proto_library][cpp] | yes |
| [C#](bzl/csharp)         |              |             |          |
| [Go][go]           | [go_proto_compile][go] | [go_proto_library][go] | yes |
| [Java][java]           | [java_proto_compile][java] | [java_proto_library][java] | yes |
| [JavaNano](bzl/javanano) |              |             |          |
| [Javascript](bzl/js)     |              |             |          |
| [Objective-C](bzl/objc)  |              |             |          |
| [Python](bzl/python)     | yes          |             |          |
| [Ruby](bzl/ruby)         |              |             |          |

1. Support for generation of protobuf classes via the `protoc` tool.
2. Support for generation + compilation of outputs with protobuf dependencies.
3. gRPC support via the `with_grpc` flag.

---

# Requirements

These are build rules for [bazel][bazel-home].  If you have not already
installed `bazel` on your workstation, follow the
[bazel instructions][bazel-install].  Here's one way (osx):


> Note about protoc and related tools: bazel and rules_protobuf will
> download or build-from-source all required dependencies, including
> the `protoc` tool and required plugins.  If you do already have
> these tools installed, bazel will not use them.

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

> Note about golang: this project uses [rules-go][rules_go] for
> `go_library`, `go_binary`, and `go_test`.

# Quick Start

Require these rules your `WORKSPACE`:

```python
git_repository(
  name = "org_pubref_rules_protobuf",
  remote = "https://github.com/pubref/rules_protobuf",
  tag = "0.3.0",
)
```

 Trigger loading of external dependencies.  Specify the language(s)
you'd like support for.


```python
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "protobuf_dependencies")
protobuf_dependencies(
   with_go = True,
   with_java = True,
   with_cpp = True,
   with_grpc = True,
)
```

> Note: refer to the [bzl/repositories.bzl][repositories.bzl] file for
> the set of external dependencies that will be loaded into your
> project.

Build a java-based gRPC library:

```python
load("@org_pubref_rules_protobuf//bzl:java/rules.bzl", "java_proto_library")

java_proto_library(
  name = "protolib",
  srcs = ["my.proto"],
  with_grpc = True,
)
```

# Examples

To run the examples & tests in this repository, clone it to your
workstation.

```sh
# Clone this repo
$ git clone https://github.com/pubref/rules_protobuf

# Go to examples/helloworld directory
$ cd rules_protobuf/examples/helloworld

# Run all tests
$ bazel test ...

# Build a server
$ bazel build cpp/server

# Run a server from the command-line
$ $(bazel info bazel-bin)/examples/helloworld/cpp/server

# Run a client
$ bazel run go/client
$ bazel run cpp/client
$ bazel run java/org/pubref/rules_closure/examples/helloworld/client:netty
```


# Overriding Dependencies

To load alternate versions of dependencies, pass in a `dict` having
the same overall structure of the [repositories.bzl][repositories.bzl]
file.  Entries having a matching key will override those found in the
file.  For example, to load a different version of
https://github.com/golang/protobuf, provide a different commit ID:

```
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "protobuf_dependencies")
protobuf_dependencies(
   with_go = True,
   overrides = {
     "com_github_golang_protobuf": {
       "commit": "2c1988e8c18d14b142c0b472624f71647cf39adb", # Aug 8, 2016
     }
   },
)
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

[protobuf-home]: https://developers.google.com/protocol-buffers/ "Protocol Buffers Developer Documentation"
[bazel-home]: http://bazel.io "Bazel Homepage"
[bazel-install]: http://bazel.io/docs/install.html "Bazel Installation"
[rules_closure]: http://github.com/bazelbuild/rules_closure "Rules Closure"
[rules_go]: http://github.com/bazelbuild/rules_go "Rules Go"

[bazel_image]: https://github.com/pubref/rules_protobuf/blob/master/images/bazel.png
[wtfcat_image]: https://github.com/pubref/rules_protobuf/blob/master/images/wtfcat.png
[grpc_image]: https://github.com/pubref/rules_protobuf/blob/master/images/gRPC.png

[cpp]: bzl/cpp
[go]: bzl/go
[java]: bzl/java
[repositories.bzl]: bzl/repositories.bzl
