package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "grpc_gateway",
    importmap = {
        "google/api/annotations.proto": "github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis/google/api",
    },
    supports_pb = False,
    supports_grpc = True,
    grpc_plugin = "@com_github_grpc_ecosystem_grpc_gateway//:protoc-gen-grpc-gateway_bin",
    grpc_plugin_name = "grpc-gateway",
    grpc_file_extensions = [".pb.gw.go"],
    grpc_inputs = [
        "@com_github_grpc_ecosystem_grpc_gateway//:googleapi_protos",
    ],
    grpc_imports = [
        "external/com_github_grpc_ecosystem_grpc_gateway/third_party/googleapis/",
        "external/com_github_google_protobuf/src/",
    ],
    prefix = "//:go_prefix",
)

proto_language(
    name = "pb_gateway",
    pb_plugin_name = "go",
    pb_file_extensions = [".pb.go"],
    pb_plugin = "@com_github_golang_protobuf//:protoc_gen_go",
    pb_plugin_implements_grpc = True,
    importmap = {
        "google/api/annotations.proto": "github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis/google/api",
    },
    pb_inputs = [
        "@com_github_grpc_ecosystem_grpc_gateway//:googleapi_protos",
    ],
    pb_imports = [
        "external/com_github_grpc_ecosystem_grpc_gateway/third_party/googleapis/",
        "external/com_github_google_protobuf/src/",
    ],
    prefix = "//:go_prefix",
)

proto_language(
    name = "swagger",
    pb_file_extensions = [".swagger.json"],
    pb_plugin = "@com_github_grpc_ecosystem_grpc_gateway//:protoc-gen-swagger_bin",
    importmap = {
        "google/api/annotations.proto": "github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis/google/api",
    },
    pb_inputs = [
        "@com_github_grpc_ecosystem_grpc_gateway//:googleapi_protos",
    ],
    pb_imports = [
        "external/com_github_grpc_ecosystem_grpc_gateway/third_party/googleapis/",
        "external/com_github_google_protobuf/src/",
    ],
    supports_grpc = True,
    prefix = "//:go_prefix",
)
