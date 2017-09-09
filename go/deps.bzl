# ****************************************************************
# List of external dependencies
# ****************************************************************

# These deps are derived empirically, starting from the grpc tag and
# then updating other dependents to the master commit.

DEPS = {

    "org_golang_google_grpc": {
        "rule": "go_repository",
        "importpath": "google.golang.org/grpc",
        "tag": "v1.6.0",
    },

    "org_golang_google_genproto": {
        "rule": "go_repository",
        "importpath": "google.golang.org/genproto",
        "commit": "595979c8a7bf586b2d293fb42246bf91a0b893d9",
    },

    "org_golang_x_net": {
        "rule": "go_repository",
        "importpath": "golang.org/x/net",
        "commit": "66aacef3dd8a676686c7ae3716979581e8b03c47", # Aug 28, 2017
    },

    "org_golang_x_text": {
        "rule": "go_repository",
        "importpath": "golang.org/x/text",
        "commit": "bd91bbf73e9a4a801adbfb97133c992678533126", # Aug 31, 2017
    },

    "com_github_golang_glog": {
        "rule": "go_repository",
        "importpath": "github.com/golang/glog",
        "commit": "23def4e6c14b4da8ac2ed8007337bc5eb5007998", # Jan 25, 2016
    },

    "com_github_golang_protobuf": {
        "rule": "go_repository",
        "importpath": "github.com/golang/protobuf",
        "commit": "17ce1425424ab154092bbb43af630bd647f3bb0d", # Sept 1, 2017
    },

}
