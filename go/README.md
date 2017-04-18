# Go Rules

| Rule | Description |
| ---: | :--- |
| [go_proto_repositories](#go_proto_repositories) | Load WORKSPACE dependencies. |
| [go_proto_compile](#go_proto_compile) | Generate protobuf source files. |
| [go_proto_library](#go_proto_library) | Generate and compiles protobuf source files. |

## go\_proto\_repositories

Enable go support by loading the dependencies in your workspace.

> IMPORTANT: This should occur after loading
> [rules_go](https://github.com/bazelbuild/rules_go).

```python
load("@org_pubref_rules_protobuf//go:rules.bzl", "go_proto_repositories")
go_proto_repositories()
```

## go\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//go`.

```python
load("@org_pubref_rules_protobuf//go:rules.bzl", "go_proto_compile")

go_proto_compile(
  name = "protos",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/message.pb.go
```

## go\_proto\_library

Pass the set of protobuf source files to the `protos` attribute.

```python
load("@org_pubref_rules_protobuf//go:rules.bzl", "go_proto_library")

go_proto_library(
  name = "protolib",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protolib
Target //:protolib up-to-date:
  bazel-bin/protolib.a
```

To get the list of required compile-time dependencies in other
contexts for grpc-related code, load the list from the rules.bzl file:

```python
load("@org_pubref_rules_protobuf//go:rules.bzl", "GRPC_COMPILE_DEPS")

go_binary(
  name = "mylib",
  srcs = ["main.go"],
  deps = [
    ":protolib"
  ] + GRPC_COMPILE_DEPS,
)
```

## Import paths

To use the generated code in other libraries, you'll need to know the
correct `import` path.  For example:

```python
go_prefix("github.com/my_organization_name")
```

```python
# //go/app_1/BUILD
go_proto_library(
  name = "protolib",
  protos = ["my.proto"],
  with_grpc = True,
)
```

To use this in `go/app_2`, the import path would be:

```go
import (
    pb "github.com/my_organization_name/go/app_1/protolib"
    //  1.............................. 2....... 3.......
)
```

This import path has three parts (2 and 3 are related to the target
pattern used to identify the rule):

1. The go_prefix
2. The path to the BUILD file
3. The name of the target in the BUILD file.

First, set the namespace of your code in the root `BUILD` file via the
`go_prefix` directive from `rules_go`:

In this case its types are referred to via the `pb` alias:

```go
func main() {
	conn, err := grpc.Dial(address, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	c := pb.NewGreeterClient(conn)
    ...
}
```

The preferred strategy is to use the magic token `go_default_library`.
When this name is chosen, part 3 is not needed and should be omitted.

---

Consult source files in the
[examples/helloworld/go](../examples/helloworld/go) directory
for additional information.

---

## Well-Known Protobuf Import Mappings

This demonstrates one way to incorporate the so-called *well-known*
protos in your proto definitions.  Protoc will look to find the proto
file in the `google/protobuf/src` directory in the external workspace.
The `protoc-gen-go` plugin then performs the importmapping according
to the `importmap` attribute.  Pregenerated protobuf dependencies are
provided by the `@com_github_golang_protobuf` workspace.  A minimally
functional example is provided in
[examples/wkt/go](https://github.com/pubref/rules_protobuf/tree/master/examples/wkt/go).

```c
// foo.proto
syntax = "proto3";
import "{A}";
...
```

```python
# BUILD
go_proto_library(
  name = "protolib",
  protos = ["foo.proto"],
  importmap = {
    "{A}": "github.com/golang/protobuf/{B}",
  },
  imports = ["external/com_google_protobuf/src"],
  deps = [
    "@com_github_golang_protobuf//:{B}",
  ],
)
```

```go
// foo.go
import (
	"github.com/golang/protobuf/{B}"
)
```

| Proto Filename (A)                      | Import Name Suffix and Target Name (B) |
| ---                                     | ---                                    |
| `google/protobuf/any.proto`             |  `ptypes/any`                          |
| `google/protobuf/duration.proto`        |  `ptypes/duration`                     |
| `google/protobuf/timestamp.proto`       |  `ptypes/timestamp`                    |
| `google/protobuf/empty.proto`           |  `ptypes/empty`                        |
| `google/protobuf/struct.proto`          |  `ptypes/struct`                       |
| `google/protobuf/wrappers.proto`        |  `ptypes/wrappers`                     |
| `google/protobuf/descriptor.proto`      |  `protoc-gen-go/descriptor`            |
| `google/protobuf/compiler/plugin.proto` |  `protoc-gen-go/plugin`                |


## The `go_package` option

Never versions of the `protoc-gen-go` plugin have direct support for
the `go_package` option
(https://github.com/golang/protobuf/issues/139).  If you have proto
files that declare the `go_package` option, you'll need to explicitly
declare that in the generating rule.  For example,
[google/api/label.proto](https://github.com/googleapis/googleapis/blob/master/google/api/label.proto) appears as follows:

```protobuf
syntax = "proto3";

package google.api;

option go_package = "google.golang.org/genproto/googleapis/api/label;label";


// A description of a label.
message LabelDescriptor {
  ...
}
...
```

See the [tests/external_proto_library](tests/external_proto_library) example wherein the `go_proto_library` defines this:

```python
go_proto_library(
    name = "go_label_proto",
    protos = [
        "google/api/label.proto",
    ],
    go_package = "google.golang.org/genproto/googleapis/api/label",
    verbose = 0,
)
```
