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
        "commit": "61c34cc7e0c7a0d85e4237d665e622640279ff3d", # Jan 2, 2018
        "build_file_proto_mode": "legacy",
    },

    "com_github_grpc_ecosystem_grpc_gateway_googleapis": {
        "rule": "new_http_archive",
        "url": "https://github.com/grpc-ecosystem/grpc-gateway/archive/61c34cc7e0c7a0d85e4237d665e622640279ff3d.zip",
        "strip_prefix": "grpc-gateway-61c34cc7e0c7a0d85e4237d665e622640279ff3d/third_party/googleapis",
        "sha256": "61845e0f6a8c44cad46e3c212fe1b6664cb2a49f235aa6e6da0be42fbedf8b96",
        "build_file_content": GOOGLEAPIS_BUILD_FILE,
    },

    "org_golang_google_genproto": {
        "rule": "go_repository",
        "importpath": "google.golang.org/genproto",
        "commit": "a8101f21cf983e773d0c1133ebc5424792003214", # Dec 2017
    },


}
