load("//bzl:deps.bzl", "require")

def deps(opts = {}):
  require("com_github_golang_glog", opts)
  require("com_github_golang_protobuf", opts)
  require("org_golang_google_grpc", opts)
  require("org_golang_x_net", opts)
