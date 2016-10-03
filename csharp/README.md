# C# Rules

| Rule | Description |
| ---: | :--- |
| [csharp_proto_repositories](#csharp_proto_repositories) | Load WORKSPACE dependencies. |
| [csharp_proto_compile](#csharp_proto_compile) | Generate protobuf source files. |
| [csharp_proto_library](#csharp_proto_library) | Generate and compiles protobuf source files. |

## csharp\_proto\_repositories

Enable C# support by loading the dependencies in your workspace.

> IMPORTANT: C# currently requires a forked version of
> [rules_dotnet](https://github.com/bazelbuild/rules_dotnet) having
> support for the `new_nuget_package` rule found in
> https://github.com/pcj/rules_dotnet.  This will change once these
> changes are integrated upstream.

```python
git_repository(
    name = "io_bazel_rules_dotnet",
    remote = "https://github.com/pcj/rules_dotnet.git",
    commit = "ed06be64a1df2b446516bf0890bd0b4d41af381a",
)
csharp_repositories(use_local_mono = False) # or true, if you prefer

load("@org_pubref_rules_protobuf//csharp:rules.bzl", "csharp_proto_repositories")
csharp_proto_repositories()
```

## csharp\_proto\_compile

This is a thin wrapper over the
[proto_compile](../protobuf#proto_compile) rule having language
`@org_pubref_rules_protobuf//csharp`.

```python
load("@org_pubref_rules_protobuf//csharp:rules.bzl", "csharp_proto_compile")

csharp_proto_compile(
  name = "protos",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :protos
Target //:protos up-to-date:
  bazel-genfiles/Message.cs
```

## csharp\_proto\_library

Pass the set of protobuf source files to the `protos` attribute.

```python
load("@org_pubref_rules_protobuf//csharp:rules.bzl", "csharp_proto_library")

csharp_proto_library(
  name = "Helloworld",
  protos = ["message.proto"],
  with_grpc = True,
)
```

```sh
$ bazel build :Helloworld
Target //:Helloworld up-to-date:
  bazel-bin/Helloworld.dll
  bazel-bin/Helloworld.xml
```

To get the list of required compile-time dependencies in other
contexts for grpc-related code, load the list from the rules.bzl file:

```python
load("@org_pubref_rules_protobuf//csharp:rules.bzl", "GRPC_COMPILE_DEPS")

csharp_binary(
  name = "mylib",
  srcs = ['MyApp.cs'],
  deps = [
    ":protolib"
  ] + GRPC_COMPILE_DEPS,
)
```

Consult source files in the
[examples/helloworld/csharp](../examples/helloworld/csharp) directory
for additional information.
