package(default_visibility = ["//visibility:public"])

load("//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "grpc_gateway",
    grpc_file_extensions = [".pb.gw.go"],
    grpc_imports = [
        "external/com_google_protobuf/src/",
        "external/com_github_grpc_ecosystem_grpc_gateway_googleapis/",
    ],
    grpc_inputs = [
        "@com_google_protobuf//:well_known_protos",
        "@com_github_grpc_ecosystem_grpc_gateway_googleapis//:annotations_protos",
        "@org_golang_google_genproto//googleapis/api/annotations:go_default_library",
    ],
    grpc_plugin = "@com_github_grpc_ecosystem_grpc_gateway//protoc-gen-grpc-gateway",
    grpc_plugin_name = "grpc-gateway",
    importmap = {
        "google/api/annotations.proto": "google.golang.org/genproto/googleapis/api/annotations",
    },
    supports_grpc = True,
    supports_pb = False,
)

proto_language(
    name = "pb_gateway",
    importmap = {
        "google/api/annotations.proto": "google.golang.org/genproto/googleapis/api/annotations",
    },
    pb_file_extensions = [".pb.go"],
    pb_imports = [
        "external/com_google_protobuf/src/",
        "external/com_github_grpc_ecosystem_grpc_gateway_googleapis/",
    ],
    pb_inputs = [
        "@com_google_protobuf//:well_known_protos",
        "@com_github_grpc_ecosystem_grpc_gateway_googleapis//:annotations_protos",
        "@org_golang_google_genproto//googleapis/api/annotations:go_default_library",
    ],
    pb_plugin = "@com_github_golang_protobuf//protoc-gen-go",
    pb_plugin_implements_grpc = True,
    pb_plugin_name = "go",
)

proto_language(
    name = "swagger",
    importmap = {
        "google/api/annotations.proto": "google.golang.org/genproto/googleapis/api/annotations",
    },
    pb_file_extensions = [".swagger.json"],
    pb_imports = [
        "external/com_google_protobuf/src/",
        "external/com_github_grpc_ecosystem_grpc_gateway_googleapis/",
    ],
    pb_inputs = [
        "@com_google_protobuf//:well_known_protos",
        "@com_github_grpc_ecosystem_grpc_gateway_googleapis//:annotations_protos",
        "@org_golang_google_genproto//googleapis/api/annotations:go_default_library",
    ],
    pb_plugin = "@com_github_grpc_ecosystem_grpc_gateway//protoc-gen-swagger",
    supports_grpc = True,
)
