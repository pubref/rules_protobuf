# `rules_protobuf_protoc`

This package provides the `protoc` dependency as well as the shared
`protoc` rule implementation.  Other language specific rules such as
`protoc_java` and `protoc_go` are essentially convenience rules that
call the `protoc` rule with the `gen_{language}` attribute set to
`True`.

For full control over protocol buffer generation in multiple
languages, invoke the `protoc` rule directly.


## Usage

Load the `protoc` rule in your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "protoc")
```

## `protoc` arguments

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `name` | `string` | The name of the rule. | (required) |
| `srcs` | `label_list` | List of protocol buffer source file(s) | (required) |
| `imports` | `string_list` | List of `--proto_path` strings that will be passed to `protoc` directly | `[]` |
| `with_grpc` | `boolean` | If `True`, additional `protoc` arguments will be assembled for the language-specific grpc plugins. | `False`
| `verbose` | `int` | No output is printed by default. | `0` |
| `protoc` | `executable` | The `protoc` binary | `//third_party/protoc:protoc_bin` |
| `gen_cpp` | `boolean` | Flag to enable cpp outputs  | `False` |
| `gen_cpp_options` | `string_list` | Options passed to the cpp protoc plugin  | `[]` |
| `gen_csharp` | `boolean` | Flag to enable csharp outputs  | `False` |
| `gen_csharp_options` | `string_list` | Options passed to the csharp protoc plugin  | `[]` |
| `gen_go` | `boolean` | Flag to enable go outputs  | `False` |
| `gen_go_options` | `string_list` | Options passed to the go protoc plugin  | `[]` |
| `gen_java` | `boolean` | Flag to enable java outputs  | `False` |
| `gen_java_options` | `string_list` | Options passed to the java protoc plugin  | `[]` |
| `gen_javanano` | `boolean` | Flag to enable JavaNano outputs  | `False` |
| `gen_javanano_options` | `string_list` | Options passed to the javanano protoc plugin  | `[]` |
| `gen_js` | `boolean` | Flag to enable javascript outputs  | `False` |
| `gen_js_options` | `string_list` | Options passed to the javascript protoc plugin  | `[]` |
| `gen_py` | `boolean` | Flag to enable python outputs  | `False` |
| `gen_py_options` | `string_list` | Options passed to the python protoc plugin  | `[]` |
| `gen_objc` | `boolean` | Flag to enable Objective-C outputs  | `False` |
| `gen_objc_options` | `string_list` | Options passed to the Objective-c protoc plugin  | `[]` |
| `gen_ruby` | `boolean` | Flag to enable ruby outputs  | `False` |
| `gen_ruby_options` | `string_list` | Options passed to the ruby protoc plugin  | `[]` |
