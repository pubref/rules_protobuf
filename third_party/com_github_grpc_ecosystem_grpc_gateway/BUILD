package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library", "go_prefix")

go_prefix("github.com/grpc-ecosystem/grpc-gateway")

go_binary(
    name = 'protoc-gen-grpc-gateway',
    srcs = [
    ],
    deps = [
    ],
)


go_library(
    name = "third_party/googleapis/google/api",
    srcs = [
        "third_party/googleapis/google/api/annotations.go",
        "third_party/googleapis/google/api/http.go"
    ],
    deps = [
        "protoc-gen-go/descriptor",
        "protoc-gen-go/plugin",
    ],
)

filegroup(
    name = 'googleapis',
    srcs = glob([
        "third_party/googleapis/google/api/*.proto",
    ]),
)

filegroup(
    name = 'googleapis_pb_files',
    srcs = glob([
        "third_party/googleapis/google/api/*.pb.go",
    ]),
)

# go_proto_library(
#     name = 'googleapis_protos',
#     srcs = glob([
#         "third_party/googleapis/google/api/*.pb.go",
#     ]),
# )

go_library(
    name = 'runtime',
    srcs = [
        "runtime/context.go",
        "runtime/convert.go",
        "runtime/doc.go",
        "runtime/errors.go",
        "runtime/handler.go",
        "runtime/marshal_json.go",
        "runtime/marshal_jsonpb.go",
        "runtime/marshaler.go",
        "runtime/marshaler_registry.go",
        "runtime/mux.go",
        "runtime/pattern.go",
        "runtime/proto2_convert.go",
        "runtime/query.go",
        "runtime/internal/stream_chunk.pb.go",
    ],
    deps = [
        "runtime/internal",
        "utilities",
        "@com_github_golang_protobuf//:jsonpb",
        "@com_github_golang_protobuf//:proto",
        "@org_golang_google_grpc//:codes",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_google_grpc//:grpclog",
        "@org_golang_google_grpc//:metadata",
        "@org_golang_x_net//:context",
    ],
)


go_library(
    name    = 'runtime/internal',
    srcs = [
        "runtime/internal/stream_chunk.pb.go",
    ],
    deps = [
        "@com_github_golang_protobuf//:proto",
    ],
)

go_library(
    name = 'utilities',
    srcs = [
        "utilities/doc.go",
        "utilities/pattern.go",
        "utilities/trie.go",
    ],
    deps = [
    ],
)
