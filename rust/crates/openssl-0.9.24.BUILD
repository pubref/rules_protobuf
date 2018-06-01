"""
cargo-raze crate build file.

DO NOT EDIT! Replaced on runs of cargo-raze
"""
package(default_visibility = ["//visibility:public"])

licenses([
  "notice", # "Apache-2.0"
])

load(
    "@io_bazel_rules_rust//rust:rust.bzl",
    "rust_library",
    "rust_binary",
    "rust_test",
    "rust_bench_test",
)

# Unsupported target "mk_certs" with type "example" omitted

rust_library(
    name = "openssl",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "@raze__bitflags__0_9_1//:bitflags",
        "@raze__foreign_types__0_3_2//:foreign_types",
        "@raze__lazy_static__1_0_1//:lazy_static",
        "@raze__libc__0_2_41//:libc",
        "@raze__openssl_sys__0_9_31//:openssl_sys",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
    ],
)

