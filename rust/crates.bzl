"""
cargo-raze crate workspace functions

DO NOT EDIT! Replaced on runs of cargo-raze
"""

def raze_fetch_remote_crates():
    native.new_http_archive(
        name = "raze__aho_corasick__0_6_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/aho-corasick/aho-corasick-0.6.4.crate",
        type = "tar.gz",
        strip_prefix = "aho-corasick-0.6.4",
        build_file = "@org_pubref_rules_protobuf//rust/crates:aho-corasick-0.6.4.BUILD",
    )

    native.new_http_archive(
        name = "raze__ansi_term__0_11_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/ansi_term/ansi_term-0.11.0.crate",
        type = "tar.gz",
        strip_prefix = "ansi_term-0.11.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:ansi_term-0.11.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__arrayvec__0_4_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/arrayvec/arrayvec-0.4.7.crate",
        type = "tar.gz",
        strip_prefix = "arrayvec-0.4.7",
        build_file = "@org_pubref_rules_protobuf//rust/crates:arrayvec-0.4.7.BUILD",
    )

    native.new_http_archive(
        name = "raze__atty__0_2_10",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/atty/atty-0.2.10.crate",
        type = "tar.gz",
        strip_prefix = "atty-0.2.10",
        build_file = "@org_pubref_rules_protobuf//rust/crates:atty-0.2.10.BUILD",
    )

    native.new_http_archive(
        name = "raze__base64__0_9_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/base64/base64-0.9.1.crate",
        type = "tar.gz",
        strip_prefix = "base64-0.9.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:base64-0.9.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__bitflags__0_9_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bitflags/bitflags-0.9.1.crate",
        type = "tar.gz",
        strip_prefix = "bitflags-0.9.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:bitflags-0.9.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__bitflags__1_0_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bitflags/bitflags-1.0.3.crate",
        type = "tar.gz",
        strip_prefix = "bitflags-1.0.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:bitflags-1.0.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__byteorder__1_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/byteorder/byteorder-1.2.3.crate",
        type = "tar.gz",
        strip_prefix = "byteorder-1.2.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:byteorder-1.2.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__bytes__0_4_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bytes/bytes-0.4.8.crate",
        type = "tar.gz",
        strip_prefix = "bytes-0.4.8",
        build_file = "@org_pubref_rules_protobuf//rust/crates:bytes-0.4.8.BUILD",
    )

    native.new_http_archive(
        name = "raze__cc__1_0_17",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cc/cc-1.0.17.crate",
        type = "tar.gz",
        strip_prefix = "cc-1.0.17",
        build_file = "@org_pubref_rules_protobuf//rust/crates:cc-1.0.17.BUILD",
    )

    native.new_http_archive(
        name = "raze__cfg_if__0_1_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cfg-if/cfg-if-0.1.3.crate",
        type = "tar.gz",
        strip_prefix = "cfg-if-0.1.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:cfg-if-0.1.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__chrono__0_2_25",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/chrono/chrono-0.2.25.crate",
        type = "tar.gz",
        strip_prefix = "chrono-0.2.25",
        build_file = "@org_pubref_rules_protobuf//rust/crates:chrono-0.2.25.BUILD",
    )

    native.new_http_archive(
        name = "raze__clap__2_31_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/clap/clap-2.31.2.crate",
        type = "tar.gz",
        strip_prefix = "clap-2.31.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:clap-2.31.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__core_foundation__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/core-foundation/core-foundation-0.2.3.crate",
        type = "tar.gz",
        strip_prefix = "core-foundation-0.2.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:core-foundation-0.2.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__core_foundation_sys__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/core-foundation-sys/core-foundation-sys-0.2.3.crate",
        type = "tar.gz",
        strip_prefix = "core-foundation-sys-0.2.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:core-foundation-sys-0.2.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__crossbeam_deque__0_3_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/crossbeam-deque/crossbeam-deque-0.3.1.crate",
        type = "tar.gz",
        strip_prefix = "crossbeam-deque-0.3.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:crossbeam-deque-0.3.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__crossbeam_epoch__0_4_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/crossbeam-epoch/crossbeam-epoch-0.4.1.crate",
        type = "tar.gz",
        strip_prefix = "crossbeam-epoch-0.4.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:crossbeam-epoch-0.4.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__crossbeam_utils__0_3_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/crossbeam-utils/crossbeam-utils-0.3.2.crate",
        type = "tar.gz",
        strip_prefix = "crossbeam-utils-0.3.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:crossbeam-utils-0.3.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__env_logger__0_4_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/env_logger/env_logger-0.4.3.crate",
        type = "tar.gz",
        strip_prefix = "env_logger-0.4.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:env_logger-0.4.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__env_logger__0_5_10",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/env_logger/env_logger-0.5.10.crate",
        type = "tar.gz",
        strip_prefix = "env_logger-0.5.10",
        build_file = "@org_pubref_rules_protobuf//rust/crates:env_logger-0.5.10.BUILD",
    )

    native.new_http_archive(
        name = "raze__foreign_types__0_3_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/foreign-types/foreign-types-0.3.2.crate",
        type = "tar.gz",
        strip_prefix = "foreign-types-0.3.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:foreign-types-0.3.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__foreign_types_shared__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/foreign-types-shared/foreign-types-shared-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "foreign-types-shared-0.1.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:foreign-types-shared-0.1.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__fuchsia_zircon__0_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fuchsia-zircon/fuchsia-zircon-0.3.3.crate",
        type = "tar.gz",
        strip_prefix = "fuchsia-zircon-0.3.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:fuchsia-zircon-0.3.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__fuchsia_zircon_sys__0_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fuchsia-zircon-sys/fuchsia-zircon-sys-0.3.3.crate",
        type = "tar.gz",
        strip_prefix = "fuchsia-zircon-sys-0.3.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:fuchsia-zircon-sys-0.3.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__futures__0_1_21",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures/futures-0.1.21.crate",
        type = "tar.gz",
        strip_prefix = "futures-0.1.21",
        build_file = "@org_pubref_rules_protobuf//rust/crates:futures-0.1.21.BUILD",
    )

    native.new_http_archive(
        name = "raze__futures_cpupool__0_1_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures-cpupool/futures-cpupool-0.1.8.crate",
        type = "tar.gz",
        strip_prefix = "futures-cpupool-0.1.8",
        build_file = "@org_pubref_rules_protobuf//rust/crates:futures-cpupool-0.1.8.BUILD",
    )

    native.new_http_archive(
        name = "raze__grpc_compiler__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpc-compiler/grpc-compiler-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "grpc-compiler-0.4.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:grpc-compiler-0.4.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__grpc_examples__0_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpc-examples/grpc-examples-0.0.0.crate",
        type = "tar.gz",
        strip_prefix = "grpc-examples-0.0.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:grpc-examples-0.0.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__grpc_interop__0_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpc-interop/grpc-interop-0.0.0.crate",
        type = "tar.gz",
        strip_prefix = "grpc-interop-0.0.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:grpc-interop-0.0.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__httpbis__0_6_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/httpbis/httpbis-0.6.1.crate",
        type = "tar.gz",
        strip_prefix = "httpbis-0.6.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:httpbis-0.6.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__humantime__1_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/humantime/humantime-1.1.1.crate",
        type = "tar.gz",
        strip_prefix = "humantime-1.1.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:humantime-1.1.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__iovec__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/iovec/iovec-0.1.2.crate",
        type = "tar.gz",
        strip_prefix = "iovec-0.1.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:iovec-0.1.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__kernel32_sys__0_2_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/kernel32-sys/kernel32-sys-0.2.2.crate",
        type = "tar.gz",
        strip_prefix = "kernel32-sys-0.2.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:kernel32-sys-0.2.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__lazy_static__0_2_11",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lazy_static/lazy_static-0.2.11.crate",
        type = "tar.gz",
        strip_prefix = "lazy_static-0.2.11",
        build_file = "@org_pubref_rules_protobuf//rust/crates:lazy_static-0.2.11.BUILD",
    )

    native.new_http_archive(
        name = "raze__lazy_static__1_0_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lazy_static/lazy_static-1.0.1.crate",
        type = "tar.gz",
        strip_prefix = "lazy_static-1.0.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:lazy_static-1.0.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__lazycell__0_6_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lazycell/lazycell-0.6.0.crate",
        type = "tar.gz",
        strip_prefix = "lazycell-0.6.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:lazycell-0.6.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__libc__0_2_41",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.41.crate",
        type = "tar.gz",
        strip_prefix = "libc-0.2.41",
        build_file = "@org_pubref_rules_protobuf//rust/crates:libc-0.2.41.BUILD",
    )

    native.new_http_archive(
        name = "raze__log__0_3_9",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/log/log-0.3.9.crate",
        type = "tar.gz",
        strip_prefix = "log-0.3.9",
        build_file = "@org_pubref_rules_protobuf//rust/crates:log-0.3.9.BUILD",
    )

    native.new_http_archive(
        name = "raze__log__0_4_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/log/log-0.4.1.crate",
        type = "tar.gz",
        strip_prefix = "log-0.4.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:log-0.4.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__memchr__2_0_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/memchr/memchr-2.0.1.crate",
        type = "tar.gz",
        strip_prefix = "memchr-2.0.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:memchr-2.0.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__memoffset__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/memoffset/memoffset-0.2.1.crate",
        type = "tar.gz",
        strip_prefix = "memoffset-0.2.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:memoffset-0.2.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__mio__0_6_14",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/mio/mio-0.6.14.crate",
        type = "tar.gz",
        strip_prefix = "mio-0.6.14",
        build_file = "@org_pubref_rules_protobuf//rust/crates:mio-0.6.14.BUILD",
    )

    native.new_http_archive(
        name = "raze__mio_uds__0_6_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/mio-uds/mio-uds-0.6.6.crate",
        type = "tar.gz",
        strip_prefix = "mio-uds-0.6.6",
        build_file = "@org_pubref_rules_protobuf//rust/crates:mio-uds-0.6.6.BUILD",
    )

    native.new_http_archive(
        name = "raze__miow__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/miow/miow-0.2.1.crate",
        type = "tar.gz",
        strip_prefix = "miow-0.2.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:miow-0.2.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__native_tls__0_1_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/native-tls/native-tls-0.1.5.crate",
        type = "tar.gz",
        strip_prefix = "native-tls-0.1.5",
        build_file = "@org_pubref_rules_protobuf//rust/crates:native-tls-0.1.5.BUILD",
    )

    native.new_http_archive(
        name = "raze__net2__0_2_32",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/net2/net2-0.2.32.crate",
        type = "tar.gz",
        strip_prefix = "net2-0.2.32",
        build_file = "@org_pubref_rules_protobuf//rust/crates:net2-0.2.32.BUILD",
    )

    native.new_http_archive(
        name = "raze__nodrop__0_1_12",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/nodrop/nodrop-0.1.12.crate",
        type = "tar.gz",
        strip_prefix = "nodrop-0.1.12",
        build_file = "@org_pubref_rules_protobuf//rust/crates:nodrop-0.1.12.BUILD",
    )

    native.new_http_archive(
        name = "raze__num__0_1_42",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num/num-0.1.42.crate",
        type = "tar.gz",
        strip_prefix = "num-0.1.42",
        build_file = "@org_pubref_rules_protobuf//rust/crates:num-0.1.42.BUILD",
    )

    native.new_http_archive(
        name = "raze__num_integer__0_1_38",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-integer/num-integer-0.1.38.crate",
        type = "tar.gz",
        strip_prefix = "num-integer-0.1.38",
        build_file = "@org_pubref_rules_protobuf//rust/crates:num-integer-0.1.38.BUILD",
    )

    native.new_http_archive(
        name = "raze__num_iter__0_1_37",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-iter/num-iter-0.1.37.crate",
        type = "tar.gz",
        strip_prefix = "num-iter-0.1.37",
        build_file = "@org_pubref_rules_protobuf//rust/crates:num-iter-0.1.37.BUILD",
    )

    native.new_http_archive(
        name = "raze__num_traits__0_2_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-traits/num-traits-0.2.4.crate",
        type = "tar.gz",
        strip_prefix = "num-traits-0.2.4",
        build_file = "@org_pubref_rules_protobuf//rust/crates:num-traits-0.2.4.BUILD",
    )

    native.new_http_archive(
        name = "raze__num_cpus__1_8_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num_cpus/num_cpus-1.8.0.crate",
        type = "tar.gz",
        strip_prefix = "num_cpus-1.8.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:num_cpus-1.8.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__openssl__0_9_24",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/openssl/openssl-0.9.24.crate",
        type = "tar.gz",
        strip_prefix = "openssl-0.9.24",
        build_file = "@org_pubref_rules_protobuf//rust/crates:openssl-0.9.24.BUILD",
    )

    native.new_http_archive(
        name = "raze__openssl_sys__0_9_31",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/openssl-sys/openssl-sys-0.9.31.crate",
        type = "tar.gz",
        strip_prefix = "openssl-sys-0.9.31",
        build_file = "@org_pubref_rules_protobuf//rust/crates:openssl-sys-0.9.31.BUILD",
    )

    native.new_http_archive(
        name = "raze__pkg_config__0_3_11",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/pkg-config/pkg-config-0.3.11.crate",
        type = "tar.gz",
        strip_prefix = "pkg-config-0.3.11",
        build_file = "@org_pubref_rules_protobuf//rust/crates:pkg-config-0.3.11.BUILD",
    )

    native.new_http_archive(
        name = "raze__quick_error__1_2_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/quick-error/quick-error-1.2.2.crate",
        type = "tar.gz",
        strip_prefix = "quick-error-1.2.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:quick-error-1.2.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__rand__0_4_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand/rand-0.4.2.crate",
        type = "tar.gz",
        strip_prefix = "rand-0.4.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:rand-0.4.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__redox_syscall__0_1_40",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/redox_syscall/redox_syscall-0.1.40.crate",
        type = "tar.gz",
        strip_prefix = "redox_syscall-0.1.40",
        build_file = "@org_pubref_rules_protobuf//rust/crates:redox_syscall-0.1.40.BUILD",
    )

    native.new_http_archive(
        name = "raze__redox_termios__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/redox_termios/redox_termios-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "redox_termios-0.1.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:redox_termios-0.1.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__regex__0_2_11",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex/regex-0.2.11.crate",
        type = "tar.gz",
        strip_prefix = "regex-0.2.11",
        build_file = "@org_pubref_rules_protobuf//rust/crates:regex-0.2.11.BUILD",
    )

    native.new_http_archive(
        name = "raze__regex__1_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex/regex-1.0.0.crate",
        type = "tar.gz",
        strip_prefix = "regex-1.0.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:regex-1.0.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__regex_syntax__0_5_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex-syntax/regex-syntax-0.5.6.crate",
        type = "tar.gz",
        strip_prefix = "regex-syntax-0.5.6",
        build_file = "@org_pubref_rules_protobuf//rust/crates:regex-syntax-0.5.6.BUILD",
    )

    native.new_http_archive(
        name = "raze__regex_syntax__0_6_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex-syntax/regex-syntax-0.6.0.crate",
        type = "tar.gz",
        strip_prefix = "regex-syntax-0.6.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:regex-syntax-0.6.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__remove_dir_all__0_5_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/remove_dir_all/remove_dir_all-0.5.1.crate",
        type = "tar.gz",
        strip_prefix = "remove_dir_all-0.5.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:remove_dir_all-0.5.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__safemem__0_2_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/safemem/safemem-0.2.0.crate",
        type = "tar.gz",
        strip_prefix = "safemem-0.2.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:safemem-0.2.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__schannel__0_1_12",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/schannel/schannel-0.1.12.crate",
        type = "tar.gz",
        strip_prefix = "schannel-0.1.12",
        build_file = "@org_pubref_rules_protobuf//rust/crates:schannel-0.1.12.BUILD",
    )

    native.new_http_archive(
        name = "raze__scoped_tls__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/scoped-tls/scoped-tls-0.1.2.crate",
        type = "tar.gz",
        strip_prefix = "scoped-tls-0.1.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:scoped-tls-0.1.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__scopeguard__0_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/scopeguard/scopeguard-0.3.3.crate",
        type = "tar.gz",
        strip_prefix = "scopeguard-0.3.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:scopeguard-0.3.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__security_framework__0_1_16",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/security-framework/security-framework-0.1.16.crate",
        type = "tar.gz",
        strip_prefix = "security-framework-0.1.16",
        build_file = "@org_pubref_rules_protobuf//rust/crates:security-framework-0.1.16.BUILD",
    )

    native.new_http_archive(
        name = "raze__security_framework_sys__0_1_16",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/security-framework-sys/security-framework-sys-0.1.16.crate",
        type = "tar.gz",
        strip_prefix = "security-framework-sys-0.1.16",
        build_file = "@org_pubref_rules_protobuf//rust/crates:security-framework-sys-0.1.16.BUILD",
    )

    native.new_http_archive(
        name = "raze__slab__0_3_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/slab/slab-0.3.0.crate",
        type = "tar.gz",
        strip_prefix = "slab-0.3.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:slab-0.3.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__slab__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/slab/slab-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "slab-0.4.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:slab-0.4.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__strsim__0_7_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/strsim/strsim-0.7.0.crate",
        type = "tar.gz",
        strip_prefix = "strsim-0.7.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:strsim-0.7.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__tempdir__0_3_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tempdir/tempdir-0.3.7.crate",
        type = "tar.gz",
        strip_prefix = "tempdir-0.3.7",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tempdir-0.3.7.BUILD",
    )

    native.new_http_archive(
        name = "raze__termcolor__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/termcolor/termcolor-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "termcolor-0.3.6",
        build_file = "@org_pubref_rules_protobuf//rust/crates:termcolor-0.3.6.BUILD",
    )

    native.new_http_archive(
        name = "raze__termion__1_5_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/termion/termion-1.5.1.crate",
        type = "tar.gz",
        strip_prefix = "termion-1.5.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:termion-1.5.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__textwrap__0_9_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/textwrap/textwrap-0.9.0.crate",
        type = "tar.gz",
        strip_prefix = "textwrap-0.9.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:textwrap-0.9.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__thread_local__0_3_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/thread_local/thread_local-0.3.5.crate",
        type = "tar.gz",
        strip_prefix = "thread_local-0.3.5",
        build_file = "@org_pubref_rules_protobuf//rust/crates:thread_local-0.3.5.BUILD",
    )

    native.new_http_archive(
        name = "raze__time__0_1_40",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/time/time-0.1.40.crate",
        type = "tar.gz",
        strip_prefix = "time-0.1.40",
        build_file = "@org_pubref_rules_protobuf//rust/crates:time-0.1.40.BUILD",
    )

    native.new_http_archive(
        name = "raze__tls_api__0_1_19",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tls-api/tls-api-0.1.19.crate",
        type = "tar.gz",
        strip_prefix = "tls-api-0.1.19",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tls-api-0.1.19.BUILD",
    )

    native.new_http_archive(
        name = "raze__tls_api_native_tls__0_1_19",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tls-api-native-tls/tls-api-native-tls-0.1.19.crate",
        type = "tar.gz",
        strip_prefix = "tls-api-native-tls-0.1.19",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tls-api-native-tls-0.1.19.BUILD",
    )

    native.new_http_archive(
        name = "raze__tls_api_stub__0_1_19",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tls-api-stub/tls-api-stub-0.1.19.crate",
        type = "tar.gz",
        strip_prefix = "tls-api-stub-0.1.19",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tls-api-stub-0.1.19.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio__0_1_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio/tokio-0.1.6.crate",
        type = "tar.gz",
        strip_prefix = "tokio-0.1.6",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-0.1.6.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_core__0_1_17",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-core/tokio-core-0.1.17.crate",
        type = "tar.gz",
        strip_prefix = "tokio-core-0.1.17",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-core-0.1.17.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_executor__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-executor/tokio-executor-0.1.2.crate",
        type = "tar.gz",
        strip_prefix = "tokio-executor-0.1.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-executor-0.1.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_fs__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-fs/tokio-fs-0.1.0.crate",
        type = "tar.gz",
        strip_prefix = "tokio-fs-0.1.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-fs-0.1.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_io__0_1_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-io/tokio-io-0.1.6.crate",
        type = "tar.gz",
        strip_prefix = "tokio-io-0.1.6",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-io-0.1.6.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_reactor__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-reactor/tokio-reactor-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "tokio-reactor-0.1.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-reactor-0.1.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_tcp__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-tcp/tokio-tcp-0.1.0.crate",
        type = "tar.gz",
        strip_prefix = "tokio-tcp-0.1.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-tcp-0.1.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_threadpool__0_1_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-threadpool/tokio-threadpool-0.1.3.crate",
        type = "tar.gz",
        strip_prefix = "tokio-threadpool-0.1.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-threadpool-0.1.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_timer__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-timer/tokio-timer-0.1.2.crate",
        type = "tar.gz",
        strip_prefix = "tokio-timer-0.1.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-timer-0.1.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_timer__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-timer/tokio-timer-0.2.3.crate",
        type = "tar.gz",
        strip_prefix = "tokio-timer-0.2.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-timer-0.2.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_tls_api__0_1_19",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-tls-api/tokio-tls-api-0.1.19.crate",
        type = "tar.gz",
        strip_prefix = "tokio-tls-api-0.1.19",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-tls-api-0.1.19.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_udp__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-udp/tokio-udp-0.1.0.crate",
        type = "tar.gz",
        strip_prefix = "tokio-udp-0.1.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-udp-0.1.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__tokio_uds__0_1_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-uds/tokio-uds-0.1.7.crate",
        type = "tar.gz",
        strip_prefix = "tokio-uds-0.1.7",
        build_file = "@org_pubref_rules_protobuf//rust/crates:tokio-uds-0.1.7.BUILD",
    )

    native.new_http_archive(
        name = "raze__ucd_util__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/ucd-util/ucd-util-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "ucd-util-0.1.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:ucd-util-0.1.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__unicode_width__0_1_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unicode-width/unicode-width-0.1.5.crate",
        type = "tar.gz",
        strip_prefix = "unicode-width-0.1.5",
        build_file = "@org_pubref_rules_protobuf//rust/crates:unicode-width-0.1.5.BUILD",
    )

    native.new_http_archive(
        name = "raze__unix_socket__0_5_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unix_socket/unix_socket-0.5.0.crate",
        type = "tar.gz",
        strip_prefix = "unix_socket-0.5.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:unix_socket-0.5.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__unreachable__1_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unreachable/unreachable-1.0.0.crate",
        type = "tar.gz",
        strip_prefix = "unreachable-1.0.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:unreachable-1.0.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__utf8_ranges__1_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/utf8-ranges/utf8-ranges-1.0.0.crate",
        type = "tar.gz",
        strip_prefix = "utf8-ranges-1.0.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:utf8-ranges-1.0.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__vcpkg__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/vcpkg/vcpkg-0.2.3.crate",
        type = "tar.gz",
        strip_prefix = "vcpkg-0.2.3",
        build_file = "@org_pubref_rules_protobuf//rust/crates:vcpkg-0.2.3.BUILD",
    )

    native.new_http_archive(
        name = "raze__vec_map__0_8_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/vec_map/vec_map-0.8.1.crate",
        type = "tar.gz",
        strip_prefix = "vec_map-0.8.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:vec_map-0.8.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__void__1_0_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/void/void-1.0.2.crate",
        type = "tar.gz",
        strip_prefix = "void-1.0.2",
        build_file = "@org_pubref_rules_protobuf//rust/crates:void-1.0.2.BUILD",
    )

    native.new_http_archive(
        name = "raze__winapi__0_2_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.2.8.crate",
        type = "tar.gz",
        strip_prefix = "winapi-0.2.8",
        build_file = "@org_pubref_rules_protobuf//rust/crates:winapi-0.2.8.BUILD",
    )

    native.new_http_archive(
        name = "raze__winapi__0_3_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.3.4.crate",
        type = "tar.gz",
        strip_prefix = "winapi-0.3.4",
        build_file = "@org_pubref_rules_protobuf//rust/crates:winapi-0.3.4.BUILD",
    )

    native.new_http_archive(
        name = "raze__winapi_build__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-build/winapi-build-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "winapi-build-0.1.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:winapi-build-0.1.1.BUILD",
    )

    native.new_http_archive(
        name = "raze__winapi_i686_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-i686-pc-windows-gnu/winapi-i686-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "winapi-i686-pc-windows-gnu-0.4.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:winapi-i686-pc-windows-gnu-0.4.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__winapi_x86_64_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-x86_64-pc-windows-gnu/winapi-x86_64-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",
        build_file = "@org_pubref_rules_protobuf//rust/crates:winapi-x86_64-pc-windows-gnu-0.4.0.BUILD",
    )

    native.new_http_archive(
        name = "raze__wincolor__0_1_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/wincolor/wincolor-0.1.6.crate",
        type = "tar.gz",
        strip_prefix = "wincolor-0.1.6",
        build_file = "@org_pubref_rules_protobuf//rust/crates:wincolor-0.1.6.BUILD",
    )

    native.new_http_archive(
        name = "raze__ws2_32_sys__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/ws2_32-sys/ws2_32-sys-0.2.1.crate",
        type = "tar.gz",
        strip_prefix = "ws2_32-sys-0.2.1",
        build_file = "@org_pubref_rules_protobuf//rust/crates:ws2_32-sys-0.2.1.BUILD",
    )
