package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # BSD

genrule(
    name = "protoc_bin",
    srcs = select({
        ":darwin": ["@pubref_rules_protobuf_protoc_macosx//file"],
        "//conditions:default": ["@pubref_rules_protobuf_protoc_linux_x86_64//file"],
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

# java_library(
#     name = "protobuf-java",
#     visibility = ["//visibility:public"],
#     exports = [
#         "@com_google_protobuf_protobuf_java//jar",
#     ],
# )
