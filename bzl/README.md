The `bzl/` directory contains bazel skylark code that implements
protocol buffer generation for the supported languages.  This file
lists attributes and behavior that is shared across all languages.

# `*_proto_compile` attributes

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `name` | `string` | The name of the rule (required) | `""` |
| `imports` | `string_list` | Additional paths to be passed as `-I` arguments to the protoc tool.  | `[]` |
| `protos` | `label_list` of file type `.proto` | The set of protobuf source files to compile. Must not be empty.  | `[]` |
| `proto_deps` | `label_list` having provider `proto` | A list of `*_proto_library` that the calling rule is dependent upon. | `[]` |
| `proto_root` | `string` | A path that shifts the directory scope of the computed execution root  | `""` |
| `protoc` | executable `label` | Used to override the default protoc binary tool. | `//external:protoc` |
| `gen_{LANG}` | `boolean` | Enable/disable protobuf output on a language-specific basis. | Usually `True` |
| `gen_{LANG}_grpc` | `boolean` | Enable/disable gRPC output on a language-specific basis. | `False` |
| `gen_{LANG}_protobuf_binary` | executable `label` | Use to override the plugin executable on a language-specific basis.  This attribute will not exist if this the language does not require a plugin for it. | *Implementation-specific* |
| `gen_{LANG}_protobuf_options` | `string_list` | Additional options to be bundled into to the `--{LANG}_out` argument. | `[]` |
| `gen_{LANG}_grpc_binary` | executable `label` | Use to override the grpc plugin executable on a language-specific basis.  This attribute will not exist if this the language does support or require a plugin for this. | *Implementation-specific* |
| `gen_{LANG}_grpc_options` | `string_list` | Additional options to be bundled into to the `--grpc-{LANG}_out` argument. | `[]` |
| `outs` | `output_list` | Permits language implementation to specify additional implicit output targets.  Currently only used by the java implementations which expose `%{name}.srcjar` as an implicit handle to the generated sourcefiles.` | `{}` |
| `output_to_workspace` | `boolean` | Under normal operation, generated code is placed in the bazel sandbox and does not need to be checked in into version control.  However, your requirements may be such that is necessary to check these generated files in.  Setting this flag to `True` will emit generated `*.pb.*` files into in your workspace alongside the `*.proto` source files.  Please make sure you're sure you want to do this as it has the potential for unwanted overwrite of source files.  | `False` |


# `*_proto_library` attributes

The attributes `protoc`, `protos`, `proto_deps`, `imports`,
`output_to_workspace`, `verbose`, `with_grpc` are included in all
`*_proto_library` rules, as described above.

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `name` | `string` | The name of the library rule (required).  The implicit output target `%{name}.pb` refers to the corresponding proto_compile rule. | `""` |
| `proto_args` | `dict` | A dictionary of arguments to be passed to the `*_proto_compile` implementation. | `{}` |
| `srcs` | `label_list` of file type specific to library rule | Additional source files passed to the implementing library rule (for example, `cc_library`  | `[]` |
| `deps` | `label_list` having provider specific to library rule | Additional dependencies  passed to the implementing library rule (for example, `cc_library`  | `[]` |
| `**kwargs` | `dict` | Additional extra arguments will be passed directly to the library rule implementation (for example, `cc_library` | `{}` |
