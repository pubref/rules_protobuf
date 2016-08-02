def deps(
  omit_com_github_grpc_grpc = False,
):

  if not omit_com_github_grpc_grpc:
    com_github_grpc_grpc()


def com_github_grpc_grpc():
  native.git_repository(
    name = "com_github_grpc_grpc",
    remote = "https://github.com/grpc/grpc.git",
    tag = "v0.15.2",
    #build_file = "//third_party/com_github_grpc_grpc:BUILD",
  )
