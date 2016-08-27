# `rules_protobuf` Javascript Support

There is no `js_proto_library` implemented here.  It is recommended to
use the `js_proto_compile` as a provider of source files to the
[closure_js_library](https://github.com/bazelbuild/rules_closure#closure_js_proto_library)
rule.  For example:

```python
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_library")
load("@org_pubref_rules_protobuf//bzl:js/rules.bzl", "js_proto_compile")

js_proto_compile(
  name = "message_protos",
  protos = ["message.proto"],
)

closure_js_library(
  name = "foo",
  srcs = [
    "foo.js",
    ":message_protos",
  ],
)
```

Note that `closure_js_proto_library` is implemented in
[rules_closure](https://github.com/bazelbuild/rules_closure#closure_js_proto_library).
This is rule is definitely a viable option but does not at the time of
this writing support imports and proto::proto dependencies.


# `js_proto_compile` attributes

All common proto_compile attributes are supported, in addition to:

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `library` | `string` | The name of the library file to put all generated classes in. | `"%{name}.js"` or `%{name}_pb.js` |
| `binary` | `bool` | Should the generated code support binary data | `True` |
| `namespace_prefix` | `string`  | See protoc documentation.  | `""` |
| `add_require_for_enums` | `bool`  | See protoc documentation.  | `False` |
| `error_on_name_conflict` | `bool`  | Fail on emitted code name generation.  | `True` |
| `import_style` | `string`  | Must be one of `closure`, `commonjs`, `browser`, or `es6`  | `closure` |
