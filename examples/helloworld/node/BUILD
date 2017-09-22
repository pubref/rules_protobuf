load("@org_pubref_rules_node//node:rules.bzl", "node_binary", "node_module")
load("//node:rules.bzl", "node_proto_library")

# node_proto_library(
#     name = "api_proto_js",
#     protos = ["api.proto"],
#     with_grpc = True,
#     output_to_workspace = False,
# )


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
