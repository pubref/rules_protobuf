load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "csharp_binary")
load("//csharp:rules.bzl", "csharp_proto_library")

csharp_binary(
    name = "GreeterServer",
    srcs = [
        "Program.cs",
    ],
    deps = [
        ":Helloworld",
        "@nuget_google_protobuf//:libnet45",
        "@nuget_grpc//:core",
        "@nuget_grpc//:runtime_osx",
        "@nuget_grpc//:system_interactive_async",
    ],
)

csharp_proto_library(
    name = "Helloworld",
    proto_deps = [
        "//examples/proto:csharp",
    ],
    protos = ["//examples/helloworld/proto:protos"],
    verbose = 0,
    with_grpc = True,
)
