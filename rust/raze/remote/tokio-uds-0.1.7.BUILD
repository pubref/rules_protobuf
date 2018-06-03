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


rust_library(
    name = "tokio_uds",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "@raze__bytes__0_4_8//:bytes",
        "@raze__futures__0_1_21//:futures",
        "@raze__iovec__0_1_2//:iovec",
        "@raze__libc__0_2_42//:libc",
        "@raze__log__0_3_9//:log",
        "@raze__mio__0_6_14//:mio",
        "@raze__mio_uds__0_6_6//:mio_uds",
        "@raze__tokio_core__0_1_17//:tokio_core",
        "@raze__tokio_io__0_1_6//:tokio_io",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
    ],
)

