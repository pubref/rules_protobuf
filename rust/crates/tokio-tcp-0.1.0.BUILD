"""
cargo-raze crate build file.

DO NOT EDIT! Replaced on runs of cargo-raze
"""
package(default_visibility = ["//visibility:public"])

licenses([
  "notice", # "MIT"
])

load(
    "@io_bazel_rules_rust//rust:rust.bzl",
    "rust_library",
    "rust_binary",
    "rust_test",
    "rust_bench_test",
)

# Unsupported target "chain" with type "test" omitted
# Unsupported target "echo" with type "test" omitted
# Unsupported target "limit" with type "test" omitted
# Unsupported target "stream-buffered" with type "test" omitted
# Unsupported target "tcp" with type "test" omitted

rust_library(
    name = "tokio_tcp",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "@raze__bytes__0_4_8//:bytes",
        "@raze__futures__0_1_21//:futures",
        "@raze__iovec__0_1_2//:iovec",
        "@raze__mio__0_6_14//:mio",
        "@raze__tokio_io__0_1_6//:tokio_io",
        "@raze__tokio_reactor__0_1_1//:tokio_reactor",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
        "default",
    ],
)

