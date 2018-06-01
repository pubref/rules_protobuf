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

# Unsupported target "client" with type "example" omitted

rust_library(
    name = "security_framework",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "@raze__core_foundation__0_2_3//:core_foundation",
        "@raze__core_foundation_sys__0_2_3//:core_foundation_sys",
        "@raze__libc__0_2_41//:libc",
        "@raze__security_framework_sys__0_1_16//:security_framework_sys",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
        "OSX_10_8",
        "security-framework-sys",
    ],
)

