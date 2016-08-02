# Java Support

## Usage

Load the `protoc_java` rule In your `BUILD` file:

```python
load("@org_pubref_rules_protobuf//bzl:rules.bzl", "protoc_java")
```

Generate protobuf `*.java` source files, bundled into a
`my_proto.srcjar`:

```python
protoc_java(
  name = "my_protobufs",
  srcs = ["my.proto"],

  # Default is false, so omit this if you are not using service
  # definitions in your .proto files
  with_grpc = True,

)
```

```sh
$ bazel build my_protobufs
```

And then depend on the protobuf rule in a java_library rule (for
example).  Remember that the srcjar contains java source code and not
compiled classfiles, so the protobuf rule label goes in the `srcs`
attribute and not the `deps` attribute (easy to do, not so easy to
recognize):

```python
java_library(
  name = "my_app",
  srcs = [
    "MyApp.java",
    ":my_protobufs",
  ],
  deps = [
    # Compile-time dependency for your standard protobufs
    "@com_google_protobuf_protobuf_java//jar",
    # Additional compile-time dependencies if grpc is used.
    "@com_google_guava_guava//jar",
    "@io_grpc_grpc_core//jar",
    "@io_grpc_grpc_protobuf//jar",
    "@io_grpc_grpc_stub//jar",
  ]
)
```

```sh
$ bazel build my_app
```

If your `MyApp.java` has a `main` method, you can run it with
something like:

```python
java_binary(
  name = "my_app_bin",
  main_class = "com.example.MyApp",
  runtime_deps = [
    ":my_app"

    # Additional runtime dependencies when using
    # netty as the grpc http2 provider.  If you're not using grpc,
    # these deps are not needed.
    "@io_grpc_grpc_netty//jar",
    "@io_grpc_grpc_protobuf_lite//jar",
    "@io_netty_netty_buffer//jar",
    "@io_netty_netty_codec//jar",
    "@io_netty_netty_codec_http2//jar",
    "@io_netty_netty_common//jar",
    "@io_netty_netty_handler//jar",
    "@io_netty_netty_resolver//jar",
    "@io_netty_netty_transport//jar",

  ]
)
```

```sh
$ bazel run my_app_bin
```

For the win, to create an executable jar with all runtime dependencies
packaged together in a single executable jar that can be deployed
anywhere, invoke the `{rule_name}_deploy.jar` *implicit build rule*:


```sh
$ bazel build my_app_bin_deploy.jar
$ cp bazel-bin/java/org/example/myapp/my_app_bin_deploy.jar /tmp
$ java -jar /tmp/my_app_bin_deploy.jar
```


## `protoc_java` Arguments

| Name | Type | Description | Default |
| ---- | ---- | ----------- | ------- |
| `gen_java` | `boolean` | Generate java sources (bundled in a `{name}.srcjar` file | `True` |
| `gen_java_options` | `string_list` | Optional plugin arguments |  |
| `protoc_gen_grpc_java` | `executable` | The java plugin `plugin` binary | `//third_party/protobuf:protoc_gen_grpc_java` |
