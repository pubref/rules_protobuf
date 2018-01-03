load("@org_pubref_rules_protobuf//grpc_gateway:rules.bzl", "grpc_gateway_proto_library", "grpc_gateway_swagger_compile")

grpc_gateway_proto_library(
    name = "greeter_grpc_gateway_go_proto",
    protos = [
        "greeter.proto",
    ],
    importpath = "github.com/pubref/rules_protobuf/greeter",
    visibility = [
        "//visibility:public",
    ],
)

grpc_gateway_swagger_compile(
    name = "greeter_swagger",
    protos = [
        "greeter.proto",
    ],
)
