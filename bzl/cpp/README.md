# C++ Rules

| Rule | Description |
| ---  | --- |
| `cc_proto_library` | Generates and compiles protobuf source files. |
| `cc_proto_compile` | Generates protobuf source files. |

## Installation

Enable cpp support by loading the set of cpp dependencies in your workspace.

```python
protobuf_repositories(
  with_cpp=True,
)
```


## Usage of `cc_proto_library`

Load the rule in your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:cpp/rules.bzl", "cc_proto_library")
```

Invoke the rule.  Pass the set of protobuf source files to the
`protos` attribute.

```python
cc_proto_library(
  name = "protolib",
  protos = ["my.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protolib
$ bazel build --spawn_strategy=standalone :protolib
```

> Note: there are some remaining issues with grpc++ compiling on linux
> that may require disabling the sandbox via the
> `--spawn_strategy=standalone` build option. See
> https://github.com/pubref/rules_protobuf/issues/7


When using the compiled library in other rules, `#include` the
generated files relative to the `WORKSPACE` root.  For example, the
`//examples/helloworld/proto/helloworld.proto` functions can be loaded
via:


```cpp
#include <grpc++/grpc++.h>

#include "examples/helloworld/proto/helloworld.pb.h"
#include "examples/helloworld/proto/helloworld.grpc.pb.h"
```

To get the list of required compile-time dependencies in other
contexts for grpc-related code, load the class descriptor and use the
`grpc.compile_deps` list:

```python
load("@org_pubref_rules_protobuf//bzl:cpp/class.bzl", CPP = "CLASS")

cc_library(
  name = "mylib",
  srcs = ['MyApp.cpp'],
  deps = [
    ":protolib"
  ] + CPP.grpc.compile_deps,
)
```

Consult source files in the `examples/helloworld/cpp/` directory for
additional information.
