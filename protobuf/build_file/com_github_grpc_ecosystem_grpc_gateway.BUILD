package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library", "go_prefix")

go_prefix("github.com/grpc-ecosystem/grpc-gateway")

go_library(
    name = "third_party/googleapis/google/api",
    srcs = [
        "third_party/googleapis/google/api/annotations.pb.go",
        "third_party/googleapis/google/api/http.pb.go",
    ],
    deps = [
        "@com_github_golang_protobuf//:proto",
        "@com_github_golang_protobuf//:protoc-gen-go/descriptor",
    ],
)

filegroup(
    name = "googleapi_protos",
    srcs = glob([
        "third_party/googleapis/google/api/*.proto",
    ]),
)

go_library(
    name = "runtime",
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
    name = "runtime/internal",
    srcs = [
        "runtime/internal/stream_chunk.pb.go",
    ],
    deps = [
        "@com_github_golang_protobuf//:proto",
    ],
)

go_library(
    name = "utilities",
    srcs = [
        "utilities/doc.go",
        "utilities/pattern.go",
        "utilities/trie.go",
    ],
    deps = [
    ],
)

go_binary(
    name = "protoc-gen-grpc-gateway_bin",
    srcs = [
        "protoc-gen-grpc-gateway/main.go",
    ],
    deps = [
        "protoc-gen-grpc-gateway/descriptor",
        "protoc-gen-grpc-gateway/gengateway",
        ":runtime",
        "@com_github_golang_glog//:go_default_library",
        "@com_github_golang_protobuf//:proto",
        "@com_github_golang_protobuf//:protoc-gen-go/plugin",
    ],
)

go_library(
    name = "protoc-gen-grpc-gateway/descriptor",
    srcs = [
        "protoc-gen-grpc-gateway/descriptor/registry.go",
        "protoc-gen-grpc-gateway/descriptor/services.go",
        "protoc-gen-grpc-gateway/descriptor/types.go",
    ],
    deps = [
        "protoc-gen-grpc-gateway/httprule",
        "third_party/googleapis/google/api",
        "@com_github_golang_glog//:go_default_library",
        "@com_github_golang_protobuf//:proto",
        "@com_github_golang_protobuf//:protoc-gen-go/descriptor",
        "@com_github_golang_protobuf//:protoc-gen-go/generator",
        "@com_github_golang_protobuf//:protoc-gen-go/plugin",
    ],
)

go_library(
    name = "protoc-gen-grpc-gateway/httprule",
    srcs = [
        "protoc-gen-grpc-gateway/httprule/compile.go",
        "protoc-gen-grpc-gateway/httprule/parse.go",
        "protoc-gen-grpc-gateway/httprule/types.go",
    ],
    deps = [
        ":utilities",
        "@com_github_golang_glog//:go_default_library",
    ],
)

go_library(
    name = "protoc-gen-grpc-gateway/generator",
    srcs = [
        "protoc-gen-grpc-gateway/generator/generator.go",
    ],
    deps = [
        "protoc-gen-grpc-gateway/descriptor",
        "@com_github_golang_protobuf//:protoc-gen-go/plugin",
    ],
)

go_library(
    name = "protoc-gen-grpc-gateway/gengateway",
    srcs = [
        "protoc-gen-grpc-gateway/gengateway/doc.go",
        "protoc-gen-grpc-gateway/gengateway/generator.go",
        "protoc-gen-grpc-gateway/gengateway/template.go",
    ],
    deps = [
        "protoc-gen-grpc-gateway/descriptor",
        "protoc-gen-grpc-gateway/generator",
        "utilities",
        "@com_github_golang_glog//:go_default_library",
        "@com_github_golang_protobuf//:proto",
        "@com_github_golang_protobuf//:protoc-gen-go/plugin",
    ],
)

go_binary(
    name = "protoc-gen-swagger_bin",
    srcs = [
        "protoc-gen-swagger/main.go",
    ],
    deps = [
        "protoc-gen-grpc-gateway/descriptor",
        "protoc-gen-swagger/genswagger",
        "@com_github_golang_glog//:go_default_library",
        "@com_github_golang_protobuf//:proto",
        "@com_github_golang_protobuf//:protoc-gen-go/plugin",
    ],
)

go_library(
    name = "protoc-gen-swagger/genswagger",
    srcs = [
        "protoc-gen-swagger/genswagger/doc.go",
        "protoc-gen-swagger/genswagger/generator.go",
        "protoc-gen-swagger/genswagger/template.go",
        "protoc-gen-swagger/genswagger/types.go",
    ],
    deps = [
        "protoc-gen-grpc-gateway/descriptor",
        "protoc-gen-grpc-gateway/generator",
        "@com_github_golang_glog//:go_default_library",
        "@com_github_golang_protobuf//:proto",
        "@com_github_golang_protobuf//:protoc-gen-go/descriptor",
        "@com_github_golang_protobuf//:protoc-gen-go/plugin",
    ],
)
