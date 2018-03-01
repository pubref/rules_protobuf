def _execute(rtx, cmds, print_result = False, keep_going = True):
    result = rtx.execute(cmds)
    if result.return_code:
        if not keep_going:
            fail("$ %s failed (%s)" % (" ".join(cmds), result.stderr))
    if print_result:
        print("$ %r\n%s" % (cmds, result.stdout))
    return result


# The grpc repository needs enough work that we need a custom repository
# rule to set it up.
def _grpc_archive_impl(rtx):

    rtx.download_and_extract(
        rtx.attr.url,
        output = "",
        sha256 = rtx.attr.sha256,
        type = rtx.attr.type,
        stripPrefix = rtx.attr.strip_prefix,
    )

    _execute(rtx, ["rm", "bazel/generate_cc.bzl"])
    
    rtx.symlink(rtx.path(rtx.attr.generate_cc_bzl), "bazel/generate_cc.bzl")

#
# Http archive that patches the grpc repository so that the reflection++ targets compile
# as an external workspace.
#
grpc_archive = repository_rule(
    implementation = _grpc_archive_impl,
    attrs = {
        "url": attr.string(
            default = "https://github.com/grpc/grpc/archive/d45132a2e9246b11ddd0b70c07160076d5cbbb12.zip",
        ),
        "sha256": attr.string(
            default = "5963e03382dfef143b1018148d3874453387df1b991720a9d41498957778a8c6",
        ),
        "strip_prefix": attr.string(
            default = "grpc-d45132a2e9246b11ddd0b70c07160076d5cbbb12",
        ),
        "type": attr.string(
            default = "zip",
        ),
        "generate_cc_bzl": attr.label(
            default = Label("@org_pubref_rules_protobuf//cpp:generate_cc.bzl", relative_to_caller_repository=True)
        ),
    },
)
