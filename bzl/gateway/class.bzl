load("//bzl:base/class.bzl", BASE = "CLASS")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:util.bzl", "invokesuper")

def build_tools(lang, self):
    invokesuper("build_tools", lang, self)
    self["tools"] += [
        "@com_github_grpc_ecosystem_grpc_gateway//:googleapis",
        #"@new_protobuf//:protobufs",
    ]
    self["imports"] += [
        "external/com_github_grpc_ecosystem_grpc_gateway/third_party/googleapis",
        #"external/new_protobuf/src",
        "external/com_github_google_protobuf/src",
        #"examples/helloworld/proto",
        ".",
    ]

CLASS = struct(
        parent = BASE,
        name = "go",
        short_name = "gateway",
        copy_protos_to_genfiles = True,

        protobuf = struct(
            name = GO.protobuf.name,
            file_extensions = GO.protobuf.file_extensions,
            executable = GO.protobuf.executable,
            tools = [
                "@com_github_grpc_ecosystem_grpc_gateway//:googleapis",
            ],
            default_options = [
                #"Mgoogle/api/annotations.proto=external/com_github_grpc_ecosystem_grpc_gateway/third_party/googleapis/google/api",
                #"Mgoogle/api/http.proto=external/com_github_grpc_ecosystem_grpc_gateway/third_party/googleapis/google/api",
                "Mgoogle/protobuf/descriptor.proto=external/com_github_google_protobuf/src/google/protobuf",
            ],
            requires = GO.protobuf.requires + [
                "com_github_grpc_ecosystem_grpc_gateway",
                "new_protobuf",
            ],
            compile_deps = GO.protobuf.compile_deps + [
            ],
        ),

        grpc = struct(
            name = GO.grpc.name,
            default_options = GO.grpc.default_options,
            requires = GO.grpc.requires + [
            ],
            compile_deps = GO.grpc.compile_deps + [
            ],
        ),

        build_protobuf_out = GO.build_protobuf_out,
        build_grpc_out = GO.build_grpc_out,
        build_tools = build_tools,
)
