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

# Unsupported target "bench_poll" with type "bench" omitted

rust_library(
    name = "mio",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "@raze__iovec__0_1_2//:iovec",
        "@raze__lazycell__0_6_0//:lazycell",
        "@raze__libc__0_2_41//:libc",
        "@raze__log__0_4_1//:log",
        "@raze__net2__0_2_32//:net2",
        "@raze__slab__0_4_0//:slab",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
        "default",
        "with-deprecated",
    ],
)

# Unsupported target "test" with type "test" omitted
