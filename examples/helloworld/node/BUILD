load("@org_pubref_rules_node//node:rules.bzl", "node_binary")

node_binary(
    name = "client",
    main = "greeter_client.js",
    deps = [
        "//examples/helloworld/proto:node",
        "@yarn_modules//:_all_",
    ],
)

node_binary(
    name = "server",
    main = "greeter_server.js",
    deps = [
        "//examples/helloworld/proto:node",
        "@yarn_modules//:_all_",
    ],
)
