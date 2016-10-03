# Gogo Rules

| Rule | Description |
| ---: | :--- |
| [gogo_proto_repositories](#gogo_proto_repositories) | Load WORKSPACE dependencies. |
| [gogo_proto_compile](#gogo_proto_compile) | Generate protobuf source files. |
| [gogo_proto_library](#gogo_proto_library) | Generate and compiles protobuf source files. |

## gogo\_proto\_repositories

Enable C# support by loading the dependencies in your workspace.

> IMPORTANT: This should occur after loading
> [rules_go](https://github.com/bazelbuild/rules_go).  In particular,
> your version of rules_go must be a recent one that includes
> **[gazelle](https://github.com/bazelbuild/rules_go/tree/master/go/tools/gazelle)**
> support and the `new_go_repository` rule.

```python
load("@org_pubref_rules_protobuf//gogo:rules.bzl", "gogo_proto_repositories")
gogo_proto_repositories()
```

## Usage

Usage is identical to [../go], just substitute `gogo` for `go`.
[Gogo](https://github.com/gogo/protobuf) is just an alternative
protobuf implementation.
