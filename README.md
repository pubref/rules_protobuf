# pubref_rules_protobuf

This is a minimal repository that provides a skylark rule to build
protocol buffer libraries (currently java only).  This repository will
become obsolete when protobuf generation is supported natively by
bazel itself.

## Installation

Require this external dependency your WORKSPACE and trigger loading of
external dependencies (including the protoc binary for linux or osx
and the protobuf-java class library):

```python
git_repository(
  name = "pubref_rules_protobuf",
  remote = "http://github.com/pubref/pubref_rules_protobuf",
  commit = "e7982e409deab9cb4390dd574441604e846caf7f", # or use latest commit-id
  )
load("@pubref_rules_protobuf:defs.bzl", "protobuf_repos")
protobuf_repos()
```

## Usage

Load the `protobuf_java_library` rule In your BUILD file:

```python
load("@pubref_rules_protobuf//defs.bzl", "protobuf_java_library")
```

Generate protobuf `*.java` source files, bundled into a
`proto.srcjar`:

```python
protobuf_java_library(
  name = "my_proto",
  src = "my.proto",
)
```

## Limitations

* The `src` argument takes a single `*.proto` file.  Therefore, you'll
  need a separate rule foreach `*.proto` file you want to compile.

## Options

If you have the `protoc` binary provided via another method in your
workspace, provide the appropriate label to the `protoc` argument: For
example:

```python
protobuf_java_library(
  name = "my_proto",
  src = "my.proto",
  protoc = Label("//third_party/my_custom_protobuf:protoc_bin"),
)
```

## Contributing

Contributions welcome; please create Issues or Github pull requests.

## Credits

* [@mzhaom](mzhaom]: Primary source for the skylark rule (from
  <https://github.com/mzhaom/trunk/blob/master/third_party/grpc/grpc_proto.bzl>).

* [@jart][jart]: Overall repository structure and bazel code layout
  (based on [rules_closure]).

[jart]: http://github.com/jart "Justine Tunney"
[rules_closure]: http://github.com/bazelbuild/rules_closure "Rules Closure"
