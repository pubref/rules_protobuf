# `rules_protobuf` Go Support

## `protoc_go` Arguments

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `gen_go` | `boolean` | Generate go sources (each input file generates a corresponding `{basename}.pb.go` file | `False` |
| `gen_go_options` | `string_list` | Optional plugin arguments |  |
| `protoc_gen_grpc_java` | `executable` | The java plugin `plugin` binary | `//third_party/protobuf:protoc_gen_grpc_java` |
| `protoc_gen_go` | `executable` | The go plugin `plugin` binary | `//third_party/protobuf:protoc_gen_go` |
