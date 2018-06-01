_RUST_PROTOBUF_VERSION = "2.0.1"
_RUST_PROTOBUF_SHA256 = "9fb966a5bba4d0fd4926356d6374ef5f7437cfe4a2943d60e3e8073ac066419d"
_RUST_GRPC_VERSION = "0.4.0"
_RUST_GRPC_SHA256 = "a298d14957043bd9d631ae3928b0678895f57d685d5054ad8dc154778be5f50a"

PROTOBUF_BUILD_FILE = """
package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_rust//rust:rust.bzl", "rust_binary", "rust_library")

VERSION = "%s"
rust_library(
  name = "protobuf",
  srcs = glob(["protobuf/src/**/*.rs"]),
  version = VERSION,
  crate_features = ["bytes"],
  deps = ["@raze__bytes__0_4_8//:bytes"]
)

rust_library(
  name = "protobuf_codegen",
  srcs = glob(["protobuf-codegen/src/*.rs"]),
  version = VERSION,
  deps = [":protobuf"],
)

rust_binary(
  name = "protoc_gen_rust",
  srcs = ["protobuf-codegen/src/bin/protoc-gen-rust.rs"],
  version = VERSION,
  deps = [":protobuf_codegen"],
)
""" % _RUST_PROTOBUF_VERSION

GRPC_BUILD_FILE = """
package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_rust//rust:rust.bzl", "rust_binary", "rust_library")

VERSION="%s"

rust_library(
  name = "grpc",
  srcs = glob(["grpc/src/**/*.rs"]),
  version = VERSION,
  deps = [
    "@com_github_stepancheg_rust_protobuf//:protobuf",
    "@raze__base64__0_9_1//:base64",
    "@raze__bytes__0_4_8//:bytes",
    "@raze__env_logger__0_5_10//:env_logger",
    "@raze__futures__0_1_21//:futures",
    "@raze__futures_cpupool__0_1_8//:futures_cpupool",
    "@raze__httpbis__0_6_1//:httpbis",
    "@raze__log__0_4_1//:log",
    "@raze__tls_api__0_1_19//:tls_api",
    "@raze__tls_api_stub__0_1_19//:tls_api_stub",
    "@raze__tokio_core__0_1_17//:tokio_core",
    "@raze__tokio_io__0_1_6//:tokio_io",
    "@raze__tokio_tls_api__0_1_19//:tokio_tls_api",
],
)

rust_library(
  name = "grpc_compiler",
  srcs = glob(["grpc-compiler/src/*.rs"]),
  deps = [
    "@com_github_stepancheg_rust_protobuf//:protobuf",
    "@com_github_stepancheg_rust_protobuf//:protobuf_codegen",
  ],
  version = VERSION,
)

rust_binary(
  name = "protoc_gen_rust_grpc",
  srcs = glob(["grpc-compiler/src/bin/*.rs"]),
  deps = [":grpc_compiler"],
  version = VERSION,
)
""" % _RUST_GRPC_VERSION

DEPS = {
    "com_github_stepancheg_rust_protobuf": {
        "rule": "new_http_archive",
        "sha256": _RUST_PROTOBUF_SHA256,
        "strip_prefix": "rust-protobuf-%s" % _RUST_PROTOBUF_VERSION,
        "urls": ["https://github.com/stepancheg/rust-protobuf/archive/v%s.tar.gz" % _RUST_PROTOBUF_VERSION],
        "build_file_content": PROTOBUF_BUILD_FILE,
    },
    "com_github_stepancheg_grpc_rust": {
        "rule": "new_http_archive",
        "sha256": _RUST_GRPC_SHA256,
        "strip_prefix": "grpc-rust-%s" % _RUST_GRPC_VERSION,
        "urls": ["https://github.com/stepancheg/grpc-rust/archive/v%s.tar.gz" % _RUST_GRPC_VERSION],
        "build_file_content": GRPC_BUILD_FILE,
    },
}
