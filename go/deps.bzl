# ****************************************************************
# List of external dependencies
# ****************************************************************

DEPS = {

    "org_golang_x_net": {
        "rule": "new_go_repository",
        "importpath": "golang.org/x/net",
        "commit": "2a35e686583654a1b89ca79c4ac78cb3d6529ca3",
    },

    "com_github_golang_glog": {
        "rule": "new_go_repository",
        "importpath": "github.com/golang/glog",
        "commit": "23def4e6c14b4da8ac2ed8007337bc5eb5007998", # Jan 25, 2016
    },

    "com_github_golang_protobuf": {
        "rule": "new_go_repository",
        "importpath": "github.com/golang/protobuf",
        "commit": "c3cefd437628a0b7d31b34fe44b3a7a540e98527", # Jul 27, 2016
        #"build_file": str(Label("//protobuf:build_file/com_github_golang_protobuf.BUILD")),
    },

    "org_golang_google_grpc": {
        "rule": "new_go_repository",
        "importpath": "google.golang.org/grpc",
        "tag": "v1.0.2",
    },

}
