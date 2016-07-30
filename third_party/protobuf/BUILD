package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # BSD

genrule(
    name = "protoc_bin",
    srcs = select({
        ":darwin": ["@protoc_macosx//file"],
        "//conditions:default": ["@protoc_linux_x86_64//file"],
    }),
    outs = ["protoc"],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$@",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
        "cd $$TMP",
        "unzip -q $$IN protoc",
        "mv protoc $$OUT",
        "rm -rf $$TMP",
    ]),
    executable = True,
)

config_setting(
    name = "darwin",
    values = {"cpu": "darwin"},
    visibility = ["//visibility:private"],
)
