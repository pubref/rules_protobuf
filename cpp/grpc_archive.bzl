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
    rtx.file("WORKSPACE", "workspace(name = 'com_google_grpc')")

# Http archive that patches the grpc repository so that the reflection++ targets compile
# as an external workspace.
#
grpc_archive = repository_rule(
    implementation = _grpc_archive_impl,
    attrs = {
        "url": attr.string(),
        "sha256": attr.string(),
        "strip_prefix": attr.string(),
        "type": attr.string(),
        "generate_cc_bzl": attr.label(
            default = Label("@org_pubref_rules_protobuf//cpp:generate_cc.bzl", relative_to_caller_repository=True)
        ),
    },
)
