GOOGLEAPIS_BUILD_FILE = """
filegroup(
  name = "annotations_protos",
  srcs = [
    "google/api/annotations.proto",
    "google/api/http.proto",
  ],
  visibility = ["//visibility:public"]
)
"""

# use a version that uses rules_go 0.12+. unfortunately, since the last tagged release came in may,
# we have to reference HEAD.
com_github_grpc_ecosystem_grpc_gateway_commit="bb916ca4f209e5f2a004537658d944ef4ae4409e" # Aug 7, 2018

DEPS = {
    "com_github_ghodss_yaml": {
        "rule": "go_repository",
        "importpath": "github.com/ghodss/yaml",
        "commit": "c7ce16629ff4cd059ed96ed06419dd3856fd3577",
    },

    "in_gopkg_yaml_v2": {
        "rule": "go_repository",
        "importpath": "gopkg.in/yaml.v2",
        "commit": "5420a8b6744d3b0345ab293f6fcba19c978f1183",
    },

    "com_github_grpc_ecosystem_grpc_gateway": {
        "rule": "go_repository",
        "importpath": "github.com/grpc-ecosystem/grpc-gateway",
        "commit": com_github_grpc_ecosystem_grpc_gateway_commit,
        "build_file_proto_mode": "legacy",
    },

    "com_github_grpc_ecosystem_grpc_gateway_googleapis": {
        "rule": "new_http_archive",
        "url": "https://github.com/grpc-ecosystem/grpc-gateway/archive/"+com_github_grpc_ecosystem_grpc_gateway_commit+".zip",
        "strip_prefix": "grpc-gateway-"+com_github_grpc_ecosystem_grpc_gateway_commit+"/third_party/googleapis",
        # "sha256": "b8426c25492e76dec187099fb8e9f582173df3d445cb8913ca5ce78f423779a9",
        "build_file_content": GOOGLEAPIS_BUILD_FILE,
    },

    "org_golang_google_genproto": {
        "rule": "go_repository",
        "importpath": "google.golang.org/genproto",
        "commit": "411e09b969b1170a9f0c467558eb4c4c110d9c77", # Apr 4, 2017
    },
}
