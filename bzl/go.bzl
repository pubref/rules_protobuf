load("//bzl:protoc.bzl", "protoc_attrs", "protoc_impl")

"""Utilities for building Go Protocol Buffers.
"""

def _protoc_go_attrs():
  attrs = protoc_attrs()
  attrs["gen_go"] = attr.bool(default = True)

  return attrs

protoc_go = rule(
  implementation=protoc_impl,
  attrs = _protoc_go_attrs(),
  # outputs = {
  #   "descriptor": "%{name}.descriptor.proto",
  # },
  output_to_genfiles=True,
)

# ****************************************************************
# Workspace Dependency Management
# ****************************************************************

def rules_protobuf_go(
    omit_com_github_golang_glog=False,
    omit_com_github_golang_protobuf=False,
    omit_org_golang_google_grpc=False,
):

  if not omit_com_github_golang_glog:
    com_github_golang_glog()
  if not omit_com_github_golang_protobuf:
    com_github_golang_protobuf()
  if not omit_org_golang_google_grpc:
    org_golang_google_grpc()


def com_github_golang_glog():
  native.new_git_repository(
    name = "com_github_golang_glog",
    remote = "https://github.com/golang/glog.git",
    commit = "23def4e6c14b4da8ac2ed8007337bc5eb5007998", # Jan 25, 2016
    build_file = "//bzl:com_github_golang_glog.BUILD",
  )

def com_github_golang_protobuf():
  native.new_git_repository(
    name = "com_github_golang_protobuf",
    remote = "https://github.com/golang/protobuf.git",
    commit = "c3cefd437628a0b7d31b34fe44b3a7a540e98527", # Jul 27, 2016
    build_file = "//bzl:com_github_golang_protobuf.BUILD",
  )

def org_golang_google_grpc():
  native.new_git_repository(
    name = "org_golang_google_grpc",
    remote = "https://github.com/grpc/grpc-go.git",
    #commit = "13edeeffdea7a41d5aad96c28deb4c7bd01a9397", #v1.0.0
    tag = "v1.0.0",
    build_file = "//bzl:org_golang_google_grpc.BUILD",
  )
