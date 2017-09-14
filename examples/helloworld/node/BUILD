load("@org_pubref_rules_node//node:rules.bzl", "node_binary")
load("//node:rules.bzl", "node_proto_library")

node_proto_library(
    name = "api_proto_js",
    protos = ["api.proto"],
    with_grpc = True,
)

node_binary(
    name = "client",
    main = "greeter_client.js",
    # modules = [
    #     "@npm_protobuf_stack//:modules",
    #     "@npm_grpc//:modules",
    # ],
    deps = [
        ":api_proto_js",
    ],
)

node_binary(
    name = "server",
    main = "greeter_server.js",
    # modules = [
    #     "@npm_protobuf_stack//:modules",
    #     "@npm_grpc//:modules",
    # ],
    deps = [
        ":api_proto_js",
    ],
)
