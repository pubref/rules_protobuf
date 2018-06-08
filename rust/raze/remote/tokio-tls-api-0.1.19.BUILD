"""
cargo-raze crate build file.

DO NOT EDIT! Replaced on runs of cargo-raze
"""
package(default_visibility = ["//visibility:public"])

licenses([
  "notice", # "MIT,Apache-2.0"
])

load(
    "@io_bazel_rules_rust//rust:rust.bzl",
    "rust_library",
    "rust_binary",
    "rust_test",
    "rust_bench_test",
)

# Unsupported target "bad" with type "test" omitted
# Unsupported target "smoke" with type "test" omitted

rust_library(
    name = "tokio_tls_api",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "@raze__futures__0_1_21//:futures",
        "@raze__tls_api__0_1_19//:tls_api",
        "@raze__tokio_core__0_1_17//:tokio_core",
        "@raze__tokio_io__0_1_6//:tokio_io",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    version = "0.1.19",
    crate_features = [
    ],
)

