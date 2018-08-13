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

DEPS = {
    "com_github_grpc_ecosystem_grpc_gateway": {
        "rule": "go_repository",
        "importpath": "github.com/grpc-ecosystem/grpc-gateway",
        "commit": "bb916ca4f209e5f2a004537658d944ef4ae4409e", # Aug 7, 2018
        "build_file_proto_mode": "legacy",
    },

    "com_github_grpc_ecosystem_grpc_gateway_googleapis": {
        "rule": "new_http_archive",
        "url": "https://github.com/grpc-ecosystem/grpc-gateway/archive/bb916ca4f209e5f2a004537658d944ef4ae4409e.zip",
        "strip_prefix": "grpc-gateway-bb916ca4f209e5f2a004537658d944ef4ae4409e/third_party/googleapis",
        # "sha256": "b8426c25492e76dec187099fb8e9f582173df3d445cb8913ca5ce78f423779a9",
        "build_file_content": GOOGLEAPIS_BUILD_FILE,
    },

    "org_golang_google_genproto": {
        "rule": "go_repository",
        "importpath": "google.golang.org/genproto",
        "commit": "411e09b969b1170a9f0c467558eb4c4c110d9c77", # Apr 4, 2017
    },


}
