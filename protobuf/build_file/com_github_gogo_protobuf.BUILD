package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # BSD

load("@io_bazel_rules_go//go:def.bzl", "go_prefix", "go_library", "go_binary")

go_prefix("github.com/gogo/protobuf")

go_binary(
    name = "protoc_gen_gofast",
    srcs = [
        "protoc-gen-gofast/main.go",
    ],
    deps = [
        "vanity",
        "vanity/command",
        #":proto",
        #":protoc-gen-gofast/generator",
        #":protoc-gen-gofast/grpc",
    ],
)

go_library(
    name = "vanity",
    srcs = glob(
        include = ["vanity/*.go"],
    ),
    deps = [
        "gogoproto",
        "proto",
        "protoc-gen-gogo/descriptor",
    ],
)

go_library(
    name = "vanity/command",
    srcs = glob(
        include = ["vanity/command/command.go"],
    ),
    deps = [
        "gogoproto",
        "plugin/compare",
        "proto",
        "protoc-gen-gogo/descriptor",
    ],
)

go_library(
    name = "proto",
    srcs = glob(
        include = ["proto/*.go"],
        exclude = [
            "proto/*_test.go",
            "proto/pointer_reflect.go",
        ],
    ),
)

go_library(
    name = "gogoproto",
    srcs = [
        "gogoproto/doc.go",
        "gogoproto/gogo.pb.go",
        "gogoproto/helper.go",
    ],
    deps = [
        "proto",
        "protoc-gen-gogo/descriptor",
    ],
)

go_library(
    name = "plugin/compare",
    srcs = [
        "plugin/compare/compare.go",
    ],
    deps = [
        "gogoproto",
        "proto",
        "protoc-gen-gogo/descriptor",
        "protoc-gen-gogo/generator",
        "vanity",
    ],
)

# go_library(
#     name = "protoc-gen-gofast/grpc",
#     srcs = ["protoc-gen-gofast/grpc/grpc.go"],
#     deps = [
#         "protoc-gen-gofast/descriptor",
#         "protoc-gen-gofast/generator",
#     ],
# )

go_library(
    name = "protoc-gen-gogo/generator",
    srcs = [
        "protoc-gen-gogo/generator/generator.go",
        "protoc-gen-gogo/generator/helper.go",
    ],
    deps = [
        "gogoproto",
        "proto",
        "protoc-gen-gogo/descriptor",
        "protoc-gen-gogo/plugin",
    ],
)

go_library(
    name = "protoc-gen-gogo/descriptor",
    srcs = glob(["protoc-gen-gogo/descriptor/*.go"]),
    deps = [":proto"],
)

go_library(
    name = "protoc-gen-gogo/plugin",
    srcs = ["protoc-gen-gogo/plugin/plugin.pb.go"],
    deps = [
        ":proto",
        ":protoc-gen-gogo/descriptor",
    ],
)

# go_library(
#     name = "jsonpb",
#     srcs = glob(
#         include = ["jsonpb/*.go"],
#         exclude = ["jsonpb/*_test.go"],
#     ),
#     deps = [":proto"],
# )

# go_library(
#     name = "ptypes",
#     srcs = glob(
#         include = ["ptypes/go"],
#         exclude = ["ptypes/_test.go"],
#     ),
#     deps = [
#         ":ptypes/any",
#         ":ptypes/duration",
#         ":ptypes/empty",
#         ":ptypes/struct",
#         ":ptypes/timestamp",
#         ":ptypes/wrappers",
#     ],
# )

# go_library(
#     name = "ptypes/any",
#     srcs = glob(
#         include = ["ptypes/any/*.go"],
#         exclude = ["ptypes/any/*_test.go"],
#     ),
#     deps = [":proto"],
# )

# go_library(
#     name = "ptypes/duration",
#     srcs = glob(
#         include = ["ptypes/duration/*.go"],
#         exclude = ["ptypes/duration/*_test.go"],
#     ),
#     deps = [":proto"],
# )

# go_library(
#     name = "ptypes/empty",
#     srcs = glob(
#         include = ["ptypes/empty/*.go"],
#         exclude = ["ptypes/empty/*_test.go"],
#     ),
#     deps = [":proto"],
# )

# go_library(
#     name = "ptypes/struct",
#     srcs = glob(
#         include = ["ptypes/struct/*.go"],
#         exclude = ["ptypes/struct/*_test.go"],
#     ),
#     deps = [":proto"],
# )

# go_library(
#     name = "ptypes/timestamp",
#     srcs = glob(
#         include = ["ptypes/timestamp/*.go"],
#         exclude = ["ptypes/timestamp/*_test.go"],
#     ),
#     deps = [":proto"],
# )

# go_library(
#     name = "ptypes/wrappers",
#     srcs = glob(
#         include = ["ptypes/wrappers/*.go"],
#         exclude = ["ptypes/wrappers/*_test.go"],
#     ),
#     deps = [":proto"],
# )
