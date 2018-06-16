load("@bazel_tools//tools/build_defs/repo:utils.bzl", "patch")

def _proto_http_archive_impl(ctx):
    ctx.download_and_extract(ctx.attr.url, ctx.attr.output_dir, ctx.attr.sha256, ctx.attr.type, ctx.attr.strip_prefix)
    patch(ctx)
    if ctx.attr.build_file_content:
        ctx.file("BUILD.bazel", ctx.attr.build_file_content)
            
# Alternative http_archive implementation that allows one to
# relocate the content of the repo into a subdirectory via the
# 'output_dir' attribute.  This is sort of the opposite of
# 'strip_prefix'.
        
# For example, coreos/etcd imports their protos as
# 'etcd/etcdserver/.../foo.proto'.  However, there is no 'etcd'
# subdir of the github repo, it's the assumed name of the repository
# itself.  We can overcome this by downloading it into a subdir as
# 'output_dir = "etcd"'.
        
proto_http_archive = repository_rule(
    implementation = _proto_http_archive_impl,
    attrs = {
        "url": attr.string(
            mandatory = True,
        ),
        "type": attr.string(),
        "strip_prefix": attr.string(),
        "output_dir": attr.string(),
        "sha256": attr.string(),
        "build_file_content": attr.string(),
        "patch_cmds": attr.string_list(),
    }
)
