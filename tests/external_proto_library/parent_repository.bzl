#
# Repository rule implementation that avoids the need for a
# `local_repository` rule referencing the parent WORKSPACE.
#

def _parent_repository_impl(rtx):
    # Get the absolute path if the 'source' label and convert to a string
    path = "%s" % rtx.path(rtx.attr._source)

    # Convert /Users/pcj/github/rules_protobuf/.../parent_repository.bzl
    # to      /Users/pcj/github/rules_protobuf
    parts = path.split('/')
    parent_dir = parts[0:-3]

    # Symlink the list of dirs to expose
    for dirname in rtx.attr.exposed_dirs:
        rtx.symlink('/%s' % "/".join(parent_dir + [dirname]), dirname)


parent_repository = repository_rule(
    implementation = _parent_repository_impl,
    attrs = {
        # We need to discover the absolute path of any file in the
        # current directory to symlink the parent workspace maven dir.
        "_source": attr.label(
            default = Label("//:parent_repository.bzl")
        ),
        "exposed_dirs": attr.string_list(
            default = [
                "protobuf",
                "go",
            ],
        )
    },
)
