# pubref_rules_protobuf

This is a minimal repository that provides a skylark rule to build
protocol buffer libraries (currently java only).  This repository will
become obsolete when protobuf generation is supported natively by
bazel itself.

## Installation

Load the external dependency your WORKSPACE:

```python
git_repository(
  name = "pubref_rules_protobuf",
  remote = "http://github.com/pubref/pubref_rules_protobuf",
  commit = "e7982e409deab9cb4390dd574441604e846caf7f", # or use latest commit-id
)
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

## Requirements

This repository assumes you have the `protoc` binary on your linux or
osx workstation.  This is copied to the workspace and provided as
`//third_party/protobuf:protoc_bin`.  If you have the `protoc` binary
provided by some other mechanism, pass that label into the
`protobuf_java_library` argument `protoc` to override.  For example:

```python
protobuf_java_library(
  name = "my_proto",
  src = "my.proto",
  protoc = Label("//third_party/my_custom_protobuf:protoc_bin"),
)
```

## Contributing

Contributions welcome; please create Issues or Github pull requests.
