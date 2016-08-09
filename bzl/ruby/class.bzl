load("//bzl:base/class.bzl", BASE = "CLASS")

CLASS = struct(
        name = "ruby",
        short_name = "ruby",

        protobuf = struct(
            file_extensions = [".pb.rb"],
            compile_deps = [
            ],
            requires = [
                "protobuf",
                "external_protobuf_clib",
            ],
        ),

        grpc = struct(
            executable = "//external:protoc_gen_grpc",
            name = "protoc-gen-grpc",
            file_extensions = [".grpc.pb.rb"],
            requires = [
            ],
            compile_deps = [
            ],
        ),

)
