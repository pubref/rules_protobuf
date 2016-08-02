The language specific rules such as `protoc_java` and `protoc_go` are
essentially convenience rules that call the `protoc` rule with the
`gen_{language}` attribute set to `True`.  For full control over
protocol buffer generation in multiple languages, invoke the `protoc`
rule directly.

## `protoc` Arguments (common to all generating rules)

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `name` | `string` | The name of the rule. | (required) |
| `srcs` | `label_list` | List of protocol buffer source file(s) | (required) |
| `imports` | `string_list` | List of `--import` that will be passed to `protoc` directly | `[]` |
| `with_grpc` | `boolean` | If `True`, additional `protoc` arguments will be assembled for the language-specific protoc plugins. | `False`
| `verbose` | `int` | No output is printed by default. | `0` |
| `protoc` | `executable` | The `protoc` binary | `//third_party/protoc:protoc_bin` |
