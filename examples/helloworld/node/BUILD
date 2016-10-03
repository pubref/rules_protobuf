load("@org_pubref_rules_node//node:rules.bzl", "node_binary")

# Server works, but not the the client (for reasons I dont yet
# understand)

node_binary(
    name = "client",
    main = "greeter_client.js",
    modules = [
        "@npm_protobuf_stack//:modules",
        "@npm_grpc//:modules",
    ],
    deps = [
        "//examples/helloworld/proto:node",
    ],
)

node_binary(
    name = "server",
    main = "greeter_server.js",
    modules = [
        "@npm_protobuf_stack//:modules",
        "@npm_grpc//:modules",
    ],
    deps = [
        "//examples/helloworld/proto:node",
    ],
)
