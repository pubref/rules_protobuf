load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "csharp_binary", "csharp_nunit_test")
load("//csharp:rules.bzl", "csharp_proto_library")

csharp_binary(
    name = "GreeterClient",
    srcs = [
        "Program.cs",
    ],
    deps = [
          ":Helloworld",
          "@nuget_google_protobuf//:libnet45",
          "@nuget_grpc//:core",
          "@nuget_grpc//:runtime_osx",
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


csharp_nunit_test(
    name = "GreeterClientTest",
    srcs = [
        "GreeterClientTest.cs",
    ],
    deps = [
        # This isn't quite working yet, so this test is essentially a no-op...
        #":Helloworld",
        #"@nuget_google_protobuf//:libnet45",
        #"@nuget_grpc//:core",
    ],
)
