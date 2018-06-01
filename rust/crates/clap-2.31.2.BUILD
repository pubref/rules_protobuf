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


rust_library(
    name = "clap",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "@raze__ansi_term__0_11_0//:ansi_term",
        "@raze__atty__0_2_10//:atty",
        "@raze__bitflags__1_0_3//:bitflags",
        "@raze__strsim__0_7_0//:strsim",
        "@raze__textwrap__0_9_0//:textwrap",
        "@raze__unicode_width__0_1_5//:unicode_width",
        "@raze__vec_map__0_8_1//:vec_map",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
        "ansi_term",
        "atty",
        "color",
        "default",
        "strsim",
        "suggestions",
        "vec_map",
    ],
)

