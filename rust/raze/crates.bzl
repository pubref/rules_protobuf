"""
cargo-raze crate workspace functions

DO NOT EDIT! Replaced on runs of cargo-raze
"""

def _new_http_archive(name, **kwargs):
    if not native.existing_rule(name):
        native.new_http_archive(name=name, **kwargs)

def raze_fetch_remote_crates():

    _new_http_archive(
        name = "raze__arrayvec__0_4_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/arrayvec/arrayvec-0.4.7.crate",
        type = "tar.gz",
        sha256 = "a1e964f9e24d588183fcb43503abda40d288c8657dfc27311516ce2f05675aef",
        strip_prefix = "arrayvec-0.4.7",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:arrayvec-0.4.7.BUILD"
    )

    _new_http_archive(
        name = "raze__base64__0_9_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/base64/base64-0.9.2.crate",
        type = "tar.gz",
        sha256 = "85415d2594767338a74a30c1d370b2f3262ec1b4ed2d7bba5b3faf4de40467d9",
        strip_prefix = "base64-0.9.2",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:base64-0.9.2.BUILD"
    )

    _new_http_archive(
        name = "raze__bitflags__1_0_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bitflags/bitflags-1.0.3.crate",
        type = "tar.gz",
        sha256 = "d0c54bb8f454c567f21197eefcdbf5679d0bd99f2ddbe52e84c77061952e6789",
        strip_prefix = "bitflags-1.0.3",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:bitflags-1.0.3.BUILD"
    )

    _new_http_archive(
        name = "raze__byteorder__1_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/byteorder/byteorder-1.2.3.crate",
        type = "tar.gz",
        sha256 = "74c0b906e9446b0a2e4f760cdb3fa4b2c48cdc6db8766a845c54b6ff063fd2e9",
        strip_prefix = "byteorder-1.2.3",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:byteorder-1.2.3.BUILD"
    )

    _new_http_archive(
        name = "raze__bytes__0_4_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bytes/bytes-0.4.8.crate",
        type = "tar.gz",
        sha256 = "7dd32989a66957d3f0cba6588f15d4281a733f4e9ffc43fcd2385f57d3bf99ff",
        strip_prefix = "bytes-0.4.8",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:bytes-0.4.8.BUILD"
    )

    _new_http_archive(
        name = "raze__cfg_if__0_1_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cfg-if/cfg-if-0.1.3.crate",
        type = "tar.gz",
        sha256 = "405216fd8fe65f718daa7102ea808a946b6ce40c742998fbfd3463645552de18",
        strip_prefix = "cfg-if-0.1.3",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:cfg-if-0.1.3.BUILD"
    )

    _new_http_archive(
        name = "raze__crossbeam_deque__0_3_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/crossbeam-deque/crossbeam-deque-0.3.1.crate",
        type = "tar.gz",
        sha256 = "fe8153ef04a7594ded05b427ffad46ddeaf22e63fd48d42b3e1e3bb4db07cae7",
        strip_prefix = "crossbeam-deque-0.3.1",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:crossbeam-deque-0.3.1.BUILD"
    )

    _new_http_archive(
        name = "raze__crossbeam_epoch__0_4_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/crossbeam-epoch/crossbeam-epoch-0.4.1.crate",
        type = "tar.gz",
        sha256 = "9b4e2817eb773f770dcb294127c011e22771899c21d18fce7dd739c0b9832e81",
        strip_prefix = "crossbeam-epoch-0.4.1",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:crossbeam-epoch-0.4.1.BUILD"
    )

    _new_http_archive(
        name = "raze__crossbeam_utils__0_3_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/crossbeam-utils/crossbeam-utils-0.3.2.crate",
        type = "tar.gz",
        sha256 = "d636a8b3bcc1b409d7ffd3facef8f21dcb4009626adbd0c5e6c4305c07253c7b",
        strip_prefix = "crossbeam-utils-0.3.2",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:crossbeam-utils-0.3.2.BUILD"
    )

    _new_http_archive(
        name = "raze__fuchsia_zircon__0_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fuchsia-zircon/fuchsia-zircon-0.3.3.crate",
        type = "tar.gz",
        sha256 = "2e9763c69ebaae630ba35f74888db465e49e259ba1bc0eda7d06f4a067615d82",
        strip_prefix = "fuchsia-zircon-0.3.3",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:fuchsia-zircon-0.3.3.BUILD"
    )

    _new_http_archive(
        name = "raze__fuchsia_zircon_sys__0_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fuchsia-zircon-sys/fuchsia-zircon-sys-0.3.3.crate",
        type = "tar.gz",
        sha256 = "3dcaa9ae7725d12cdb85b3ad99a434db70b468c09ded17e012d86b5c1010f7a7",
        strip_prefix = "fuchsia-zircon-sys-0.3.3",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:fuchsia-zircon-sys-0.3.3.BUILD"
    )

    _new_http_archive(
        name = "raze__futures__0_1_21",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures/futures-0.1.21.crate",
        type = "tar.gz",
        sha256 = "1a70b146671de62ec8c8ed572219ca5d594d9b06c0b364d5e67b722fc559b48c",
        strip_prefix = "futures-0.1.21",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:futures-0.1.21.BUILD"
    )

    _new_http_archive(
        name = "raze__futures_cpupool__0_1_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures-cpupool/futures-cpupool-0.1.8.crate",
        type = "tar.gz",
        sha256 = "ab90cde24b3319636588d0c35fe03b1333857621051837ed769faefb4c2162e4",
        strip_prefix = "futures-cpupool-0.1.8",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:futures-cpupool-0.1.8.BUILD"
    )

    _new_http_archive(
        name = "raze__grpc__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpc/grpc-0.4.0.crate",
        type = "tar.gz",
        sha256 = "3ec0a20eaa2682f7efe0ed9bf749a8264d1da9df9375ddfcec1643f21a4a5ec9",
        strip_prefix = "grpc-0.4.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:grpc-0.4.0.BUILD"
    )

    _new_http_archive(
        name = "raze__grpc_compiler__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpc-compiler/grpc-compiler-0.4.0.crate",
        type = "tar.gz",
        sha256 = "ae0ed7696fcbc435a4c7eb90573ea4211a2fb27d74b9a38f784bb0de025a1f18",
        strip_prefix = "grpc-compiler-0.4.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:grpc-compiler-0.4.0.BUILD"
    )

    _new_http_archive(
        name = "raze__httpbis__0_6_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/httpbis/httpbis-0.6.1.crate",
        type = "tar.gz",
        sha256 = "08dd97d857b9c194e7bff2e046f5711fa95f2532945497eca6913640eb664060",
        strip_prefix = "httpbis-0.6.1",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:httpbis-0.6.1.BUILD"
    )

    _new_http_archive(
        name = "raze__iovec__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/iovec/iovec-0.1.2.crate",
        type = "tar.gz",
        sha256 = "dbe6e417e7d0975db6512b90796e8ce223145ac4e33c377e4a42882a0e88bb08",
        strip_prefix = "iovec-0.1.2",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:iovec-0.1.2.BUILD"
    )

    _new_http_archive(
        name = "raze__kernel32_sys__0_2_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/kernel32-sys/kernel32-sys-0.2.2.crate",
        type = "tar.gz",
        sha256 = "7507624b29483431c0ba2d82aece8ca6cdba9382bff4ddd0f7490560c056098d",
        strip_prefix = "kernel32-sys-0.2.2",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:kernel32-sys-0.2.2.BUILD"
    )

    _new_http_archive(
        name = "raze__lazy_static__1_0_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lazy_static/lazy_static-1.0.1.crate",
        type = "tar.gz",
        sha256 = "e6412c5e2ad9584b0b8e979393122026cdd6d2a80b933f890dcd694ddbe73739",
        strip_prefix = "lazy_static-1.0.1",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:lazy_static-1.0.1.BUILD"
    )

    _new_http_archive(
        name = "raze__lazycell__0_6_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lazycell/lazycell-0.6.0.crate",
        type = "tar.gz",
        sha256 = "a6f08839bc70ef4a3fe1d566d5350f519c5912ea86be0df1740a7d247c7fc0ef",
        strip_prefix = "lazycell-0.6.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:lazycell-0.6.0.BUILD"
    )

    _new_http_archive(
        name = "raze__libc__0_2_42",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.42.crate",
        type = "tar.gz",
        sha256 = "b685088df2b950fccadf07a7187c8ef846a959c142338a48f9dc0b94517eb5f1",
        strip_prefix = "libc-0.2.42",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:libc-0.2.42.BUILD"
    )

    _new_http_archive(
        name = "raze__log__0_3_9",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/log/log-0.3.9.crate",
        type = "tar.gz",
        sha256 = "e19e8d5c34a3e0e2223db8e060f9e8264aeeb5c5fc64a4ee9965c062211c024b",
        strip_prefix = "log-0.3.9",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:log-0.3.9.BUILD"
    )

    _new_http_archive(
        name = "raze__log__0_4_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/log/log-0.4.2.crate",
        type = "tar.gz",
        sha256 = "6fddaa003a65722a7fb9e26b0ce95921fe4ba590542ced664d8ce2fa26f9f3ac",
        strip_prefix = "log-0.4.2",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:log-0.4.2.BUILD"
    )

    _new_http_archive(
        name = "raze__memoffset__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/memoffset/memoffset-0.2.1.crate",
        type = "tar.gz",
        sha256 = "0f9dc261e2b62d7a622bf416ea3c5245cdd5d9a7fcc428c0d06804dfce1775b3",
        strip_prefix = "memoffset-0.2.1",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:memoffset-0.2.1.BUILD"
    )

    _new_http_archive(
        name = "raze__mio__0_6_14",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/mio/mio-0.6.14.crate",
        type = "tar.gz",
        sha256 = "6d771e3ef92d58a8da8df7d6976bfca9371ed1de6619d9d5a5ce5b1f29b85bfe",
        strip_prefix = "mio-0.6.14",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:mio-0.6.14.BUILD"
    )

    _new_http_archive(
        name = "raze__mio_uds__0_6_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/mio-uds/mio-uds-0.6.6.crate",
        type = "tar.gz",
        sha256 = "84c7b5caa3a118a6e34dbac36504503b1e8dc5835e833306b9d6af0e05929f79",
        strip_prefix = "mio-uds-0.6.6",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:mio-uds-0.6.6.BUILD"
    )

    _new_http_archive(
        name = "raze__miow__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/miow/miow-0.2.1.crate",
        type = "tar.gz",
        sha256 = "8c1f2f3b1cf331de6896aabf6e9d55dca90356cc9960cca7eaaf408a355ae919",
        strip_prefix = "miow-0.2.1",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:miow-0.2.1.BUILD"
    )

    _new_http_archive(
        name = "raze__net2__0_2_32",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/net2/net2-0.2.32.crate",
        type = "tar.gz",
        sha256 = "9044faf1413a1057267be51b5afba8eb1090bd2231c693664aa1db716fe1eae0",
        strip_prefix = "net2-0.2.32",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:net2-0.2.32.BUILD"
    )

    _new_http_archive(
        name = "raze__nodrop__0_1_12",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/nodrop/nodrop-0.1.12.crate",
        type = "tar.gz",
        sha256 = "9a2228dca57108069a5262f2ed8bd2e82496d2e074a06d1ccc7ce1687b6ae0a2",
        strip_prefix = "nodrop-0.1.12",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:nodrop-0.1.12.BUILD"
    )

    _new_http_archive(
        name = "raze__num_cpus__1_8_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num_cpus/num_cpus-1.8.0.crate",
        type = "tar.gz",
        sha256 = "c51a3322e4bca9d212ad9a158a02abc6934d005490c054a2778df73a70aa0a30",
        strip_prefix = "num_cpus-1.8.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:num_cpus-1.8.0.BUILD"
    )

    _new_http_archive(
        name = "raze__protobuf__1_6_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/protobuf/protobuf-1.6.0.crate",
        type = "tar.gz",
        sha256 = "63af89a2e832acba65595d0fc9b8444f5b014356c2a7ad759d6b846c4fa52efb",
        strip_prefix = "protobuf-1.6.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:protobuf-1.6.0.BUILD"
    )

    _new_http_archive(
        name = "raze__protobuf_codegen__1_6_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/protobuf-codegen/protobuf-codegen-1.6.0.crate",
        type = "tar.gz",
        sha256 = "89f7524bbb8c6796a164d29cbd8aae51ece80e4ae2040ffb2faa875b2f6823b4",
        strip_prefix = "protobuf-codegen-1.6.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:protobuf-codegen-1.6.0.BUILD"
    )

    _new_http_archive(
        name = "raze__rand__0_4_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand/rand-0.4.2.crate",
        type = "tar.gz",
        sha256 = "eba5f8cb59cc50ed56be8880a5c7b496bfd9bd26394e176bc67884094145c2c5",
        strip_prefix = "rand-0.4.2",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:rand-0.4.2.BUILD"
    )

    _new_http_archive(
        name = "raze__safemem__0_2_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/safemem/safemem-0.2.0.crate",
        type = "tar.gz",
        sha256 = "e27a8b19b835f7aea908818e871f5cc3a5a186550c30773be987e155e8163d8f",
        strip_prefix = "safemem-0.2.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:safemem-0.2.0.BUILD"
    )

    _new_http_archive(
        name = "raze__scoped_tls__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/scoped-tls/scoped-tls-0.1.2.crate",
        type = "tar.gz",
        sha256 = "332ffa32bf586782a3efaeb58f127980944bbc8c4d6913a86107ac2a5ab24b28",
        strip_prefix = "scoped-tls-0.1.2",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:scoped-tls-0.1.2.BUILD"
    )

    _new_http_archive(
        name = "raze__scopeguard__0_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/scopeguard/scopeguard-0.3.3.crate",
        type = "tar.gz",
        sha256 = "94258f53601af11e6a49f722422f6e3425c52b06245a5cf9bc09908b174f5e27",
        strip_prefix = "scopeguard-0.3.3",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:scopeguard-0.3.3.BUILD"
    )

    _new_http_archive(
        name = "raze__slab__0_3_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/slab/slab-0.3.0.crate",
        type = "tar.gz",
        sha256 = "17b4fcaed89ab08ef143da37bc52adbcc04d4a69014f4c1208d6b51f0c47bc23",
        strip_prefix = "slab-0.3.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:slab-0.3.0.BUILD"
    )

    _new_http_archive(
        name = "raze__slab__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/slab/slab-0.4.0.crate",
        type = "tar.gz",
        sha256 = "fdeff4cd9ecff59ec7e3744cbca73dfe5ac35c2aedb2cfba8a1c715a18912e9d",
        strip_prefix = "slab-0.4.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:slab-0.4.0.BUILD"
    )

    _new_http_archive(
        name = "raze__tls_api__0_1_19",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tls-api/tls-api-0.1.19.crate",
        type = "tar.gz",
        sha256 = "b433ee8bde283064ac414932e5c8d0ce20f9820b344a09398538ec240373e8c9",
        strip_prefix = "tls-api-0.1.19",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tls-api-0.1.19.BUILD"
    )

    _new_http_archive(
        name = "raze__tls_api_stub__0_1_19",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tls-api-stub/tls-api-stub-0.1.19.crate",
        type = "tar.gz",
        sha256 = "a7029e7c7ebdfc065c10fe4a065f52837fd0907551f7b3565d406c119b46c42a",
        strip_prefix = "tls-api-stub-0.1.19",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tls-api-stub-0.1.19.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio__0_1_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio/tokio-0.1.7.crate",
        type = "tar.gz",
        sha256 = "8ee337e5f4e501fc32966fec6fe0ca0cc1c237b0b1b14a335f8bfe3c5f06e286",
        strip_prefix = "tokio-0.1.7",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-0.1.7.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_core__0_1_17",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-core/tokio-core-0.1.17.crate",
        type = "tar.gz",
        sha256 = "aeeffbbb94209023feaef3c196a41cbcdafa06b4a6f893f68779bb5e53796f71",
        strip_prefix = "tokio-core-0.1.17",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-core-0.1.17.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_executor__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-executor/tokio-executor-0.1.2.crate",
        type = "tar.gz",
        sha256 = "8cac2a7883ff3567e9d66bb09100d09b33d90311feca0206c7ca034bc0c55113",
        strip_prefix = "tokio-executor-0.1.2",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-executor-0.1.2.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_fs__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-fs/tokio-fs-0.1.0.crate",
        type = "tar.gz",
        sha256 = "76766830bbf9a2d5bfb50c95350d56a2e79e2c80f675967fff448bc615899708",
        strip_prefix = "tokio-fs-0.1.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-fs-0.1.0.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_io__0_1_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-io/tokio-io-0.1.6.crate",
        type = "tar.gz",
        sha256 = "6af9eb326f64b2d6b68438e1953341e00ab3cf54de7e35d92bfc73af8555313a",
        strip_prefix = "tokio-io-0.1.6",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-io-0.1.6.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_reactor__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-reactor/tokio-reactor-0.1.1.crate",
        type = "tar.gz",
        sha256 = "b3cedc8e5af5131dc3423ffa4f877cce78ad25259a9a62de0613735a13ebc64b",
        strip_prefix = "tokio-reactor-0.1.1",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-reactor-0.1.1.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_tcp__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-tcp/tokio-tcp-0.1.0.crate",
        type = "tar.gz",
        sha256 = "ec9b094851aadd2caf83ba3ad8e8c4ce65a42104f7b94d9e6550023f0407853f",
        strip_prefix = "tokio-tcp-0.1.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-tcp-0.1.0.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_threadpool__0_1_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-threadpool/tokio-threadpool-0.1.4.crate",
        type = "tar.gz",
        sha256 = "b3c3873a6d8d0b636e024e77b9a82eaab6739578a06189ecd0e731c7308fbc5d",
        strip_prefix = "tokio-threadpool-0.1.4",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-threadpool-0.1.4.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_timer__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-timer/tokio-timer-0.1.2.crate",
        type = "tar.gz",
        sha256 = "6131e780037787ff1b3f8aad9da83bca02438b72277850dd6ad0d455e0e20efc",
        strip_prefix = "tokio-timer-0.1.2",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-timer-0.1.2.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_timer__0_2_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-timer/tokio-timer-0.2.4.crate",
        type = "tar.gz",
        sha256 = "028b94314065b90f026a21826cffd62a4e40a92cda3e5c069cc7b02e5945f5e9",
        strip_prefix = "tokio-timer-0.2.4",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-timer-0.2.4.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_tls_api__0_1_19",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-tls-api/tokio-tls-api-0.1.19.crate",
        type = "tar.gz",
        sha256 = "e00c40dfac88e87b728026c72426a0e2d4319fa8386eae9003093a3e00aee83e",
        strip_prefix = "tokio-tls-api-0.1.19",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-tls-api-0.1.19.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_udp__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-udp/tokio-udp-0.1.0.crate",
        type = "tar.gz",
        sha256 = "137bda266504893ac4774e0ec4c2108f7ccdbcb7ac8dced6305fe9e4e0b5041a",
        strip_prefix = "tokio-udp-0.1.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-udp-0.1.0.BUILD"
    )

    _new_http_archive(
        name = "raze__tokio_uds__0_1_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tokio-uds/tokio-uds-0.1.7.crate",
        type = "tar.gz",
        sha256 = "65ae5d255ce739e8537221ed2942e0445f4b3b813daebac1c0050ddaaa3587f9",
        strip_prefix = "tokio-uds-0.1.7",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:tokio-uds-0.1.7.BUILD"
    )

    _new_http_archive(
        name = "raze__unix_socket__0_5_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unix_socket/unix_socket-0.5.0.crate",
        type = "tar.gz",
        sha256 = "6aa2700417c405c38f5e6902d699345241c28c0b7ade4abaad71e35a87eb1564",
        strip_prefix = "unix_socket-0.5.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:unix_socket-0.5.0.BUILD"
    )

    _new_http_archive(
        name = "raze__void__1_0_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/void/void-1.0.2.crate",
        type = "tar.gz",
        sha256 = "6a02e4885ed3bc0f2de90ea6dd45ebcbb66dacffe03547fadbb0eeae2770887d",
        strip_prefix = "void-1.0.2",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:void-1.0.2.BUILD"
    )

    _new_http_archive(
        name = "raze__winapi__0_2_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.2.8.crate",
        type = "tar.gz",
        sha256 = "167dc9d6949a9b857f3451275e911c3f44255842c1f7a76f33c55103a909087a",
        strip_prefix = "winapi-0.2.8",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:winapi-0.2.8.BUILD"
    )

    _new_http_archive(
        name = "raze__winapi__0_3_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.3.5.crate",
        type = "tar.gz",
        sha256 = "773ef9dcc5f24b7d850d0ff101e542ff24c3b090a9768e03ff889fdef41f00fd",
        strip_prefix = "winapi-0.3.5",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:winapi-0.3.5.BUILD"
    )

    _new_http_archive(
        name = "raze__winapi_build__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-build/winapi-build-0.1.1.crate",
        type = "tar.gz",
        sha256 = "2d315eee3b34aca4797b2da6b13ed88266e6d612562a0c46390af8299fc699bc",
        strip_prefix = "winapi-build-0.1.1",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:winapi-build-0.1.1.BUILD"
    )

    _new_http_archive(
        name = "raze__winapi_i686_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-i686-pc-windows-gnu/winapi-i686-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        sha256 = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6",
        strip_prefix = "winapi-i686-pc-windows-gnu-0.4.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:winapi-i686-pc-windows-gnu-0.4.0.BUILD"
    )

    _new_http_archive(
        name = "raze__winapi_x86_64_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-x86_64-pc-windows-gnu/winapi-x86_64-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        sha256 = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f",
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:winapi-x86_64-pc-windows-gnu-0.4.0.BUILD"
    )

    _new_http_archive(
        name = "raze__ws2_32_sys__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/ws2_32-sys/ws2_32-sys-0.2.1.crate",
        type = "tar.gz",
        sha256 = "d59cefebd0c892fa2dd6de581e937301d8552cb44489cdff035c6187cb63fa5e",
        strip_prefix = "ws2_32-sys-0.2.1",
        build_file = "@org_pubref_rules_protobuf//rust/raze/remote:ws2_32-sys-0.2.1.BUILD"
    )

