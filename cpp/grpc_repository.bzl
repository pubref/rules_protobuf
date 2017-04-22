def _execute(rtx, cmds, print_result = False, keep_going = True):
    result = rtx.execute(cmds)
    if result.return_code:
        if not keep_going:
            fail("$ %s failed (%s)" % (" ".join(cmds), result.stderr))
    if print_result:
        print("$ %r\n%s" % (cmds, result.stdout))
    return result


def _get_external_path(workspace_file, path):
    workspace_file_path = workspace_file.split('/')
    workspace_path = workspace_file_path[0:-1]
    #return "/" + "/".join(workspace_path + [path])
    return "/".join(workspace_path + [path])


def _mount_external_workspace_path(rtx,
                                   source_workspace_file,
                                   source_path,
                                   target_path = None,
                                   target_workspace_file = None):
    '''Mount a directory or file from an external workspace into this the target one.
    '''
    source = _get_external_path(source_workspace_file, source_path)
    target_path = target_path if target_path else source_path
    target = target_path
    if target_workspace_file:
        target = _get_external_path(target_workspace_file, target_path)
    rtx.symlink(source, target)
    #print("mounted %r --> %r" % (source, target))


def _setup_submodule_cares(rtx):
    cares_workspace = "%s" % rtx.path(rtx.attr._cares_workspace)
    cares_workspace_dir = _get_external_path(cares_workspace, "")

    # Remove the cares directory if it exists in this repository if it exists
    # from prior runs or as a git submodule.
    _execute(rtx, ["rm", "-rf", "third_party/cares/cares"], keep_going = True)

    # Copy the entire contents of external/com_github_c_ares_c_ares to third_party/cares/cares.
    # This is sort of a manual equivalent of git submodule init (but we dont want to use
    # git submodules or the git_repository rule... too slow for grpc repo!)
    _execute(rtx, [
        "cp",
        "-rp",
        cares_workspace_dir,
        "third_party/cares/cares",
    ], print_result = True)

    # @grpc//:WORKSPACE uses a bind rule to map '//external:cares' --> '@submodules_cares//:ares'.
    # @submodules_cares is defined as a new_local_repository using the third_party/cares/cares.BUILD
    # file.
    #
    # In this repo, we want to copy over all
    # Need to bind //external:cares to @com_google_grpc//third_party/cares:ares, so there should
    # be a build file in
    _execute(rtx, ["cat", "third_party/cares/cares.BUILD"], print_result = True)

    # Remove the original BUILD files from new_http_archive to avoid package boundary errors
    _execute(rtx, ["rm", "third_party/cares/cares/WORKSPACE"])
    _execute(rtx, ["rm", "third_party/cares/cares/BUILD"])
    _execute(rtx, ["rm", "third_party/cares/cares/BUILD.bazel"])

    # Rename the cares.BUILD file to BUILD. This has the :ares target and we're done!
    _execute(rtx, ["cp", "third_party/cares/cares.BUILD", "third_party/cares/BUILD"])


def _setup_submodule_nanopb(rtx):
    pass

#
# The grpc repository needs enough work that we need a custom repository
# rule to set it up.
#
def _grpc_repository_impl(rtx):

    ###
    # Phase 1: Setup the grpc workspace
    ##
    grpc_workspace = "%s" % rtx.path(rtx.attr._grpc_workspace)
    grpc_workspace_dir = _get_external_path(grpc_workspace, "")

    # Mount (symlink) these files & directories from the grpc repo as-is.
    _mount_external_workspace_path(rtx, grpc_workspace, "BUILD")
    _mount_external_workspace_path(rtx, grpc_workspace, "src/")
    _mount_external_workspace_path(rtx, grpc_workspace, "include/")
    _mount_external_workspace_path(rtx, grpc_workspace, "bazel/")
    _mount_external_workspace_path(rtx, grpc_workspace, "third_party/")

    ###
    # Phase 2: Setup the submodules
    ##
    _setup_submodule_cares(rtx)
    _setup_submodule_nanopb(rtx)


grpc_repository = repository_rule(
    implementation = _grpc_repository_impl,
    attrs = {
        # The WORKSPACE file for the grpc repository.
        "_grpc_workspace": attr.label(
            default = Label("@com_github_grpc_grpc2//:WORKSPACE")
        ),
        # The WORKSPACE file for the c-ares repository.
        "_cares_workspace": attr.label(
            default = Label("@com_github_c_ares_c_ares//:WORKSPACE")
        ),
        # The cares BUILD file
        # "_cares_build_file": attr.label(
        #     default = Label("//protobuf:build_file/cares.BUILD")
        # ),
    },
)
