load("//bzl:java/class.bzl", JAVA = "CLASS")

CLASS = struct(
        parent = JAVA,
        name = "javanano",
        short_name = "javanano",
        protobuf = struct(
            file_extensions = JAVA.protobuf.file_extensions,
            requires = JAVA.protobuf.requires + [
                "com_google_protobuf_nano_protobuf_javanano",
            ],
            outputs = JAVA.protobuf.outputs,
            compile_deps = JAVA.protobuf.compile_deps + [
                "@com_google_protobuf_nano_protobuf_javanano//jar",
            ],
            default_options = ["ignore_services=true"],
        ),
        grpc = struct(
            executable = JAVA.grpc.executable,
            name = JAVA.grpc.name,
            requires = JAVA.grpc.requires + [
                "io_grpc_grpc_protobuf_nano",
            ],
            default_options = ["nano"],
            compile_deps = JAVA.grpc.compile_deps + [
                "@com_google_protobuf_nano_protobuf_javanano//jar",
                "@io_grpc_grpc_protobuf_nano//jar",
            ],
        ),
        build_generated_files = JAVA.build_generated_files,
        build_grpc_out = JAVA.build_grpc_out,
        post_execute = JAVA.post_execute,
)
