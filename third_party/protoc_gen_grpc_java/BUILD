package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # BSD

genrule(
    name = "protoc_gen_grpc_java_bin",
    srcs = select({
        ":darwin": ["@protoc_gen_grpc_java_macosx//file"],
        "//conditions:default": ["@protoc_gen_grpc_java_linux_x86_64//file"],
    }),
    outs = ["protoc_gen_grpc_java"],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$@",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
    "cd $$TMP",
        "cp $$IN $$OUT",
        "rm -rf $$TMP",
    ]),
    executable = True,
)

config_setting(
    name = "darwin",
    values = {"cpu": "darwin"},
    visibility = ["//visibility:private"],
)
