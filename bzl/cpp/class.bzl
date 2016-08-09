load("//bzl:base/class.bzl", BASE = "CLASS")

CLASS = struct(
    parent = BASE,
    name = "cpp",
    short_name = "cpp",

    protobuf = struct(
        file_extensions = [".pb.h", ".pb.cc"],
        compile_deps = [
            "//external:protobuf_clib",
        ],
        requires = [
            "protobuf",
            "external_protobuf_clib",
        ],
    ),
    grpc = struct(
        executable = "//external:protoc_gen_grpc_cpp",
        name = "protoc-gen-grpc",
        file_extensions = [".grpc.pb.h", ".grpc.pb.cc"],
        requires = [
            "grpc",
            "zlib",
            "external_zlib",
            "nanopb",
            "external_nanopb",
            "boringssl",
            "libssl",
            "external_protobuf_compiler",
            "third_party_protoc",
            "external_protoc_gen_grpc_cpp",
        ],
        compile_deps = [
            "//external:protobuf_clib",
            '@com_github_grpc_grpc//:grpc++',
        ],
    ),

)
