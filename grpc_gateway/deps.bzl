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
        "rule": "new_go_repository",
        "importpath": "github.com/grpc-ecosystem/grpc-gateway",
        "commit": "2ad234c172af14e85f3be9546f6c64c768d4eccd", # Apr 4, 2017
        #"commit": "597c8c358cb7475bc9fc495af32f94065aa6b6e1", # Apr 24, 2017
        # TODO: figure out why newest commit fails with `context.go:99: undefined: metadata.NewOutgoingContext`
    },

    "com_github_grpc_ecosystem_grpc_gateway_googleapis": {
        "rule": "new_http_archive",
        "url": "http://github.com/grpc-ecosystem/grpc-gateway/archive/597c8c358cb7475bc9fc495af32f94065aa6b6e1.zip",
        "strip_prefix": "grpc-gateway-597c8c358cb7475bc9fc495af32f94065aa6b6e1/third_party/googleapis", # Apr 24, 2017
        "sha256": "36d2f6f44271bc397c3ded20a35c3b78024e873615caf417fdafde08500ca78d",
        "build_file_content": GOOGLEAPIS_BUILD_FILE,
    },

    "org_golang_google_genproto": {
        "rule": "new_go_repository",
        "importpath": "google.golang.org/genproto",
        "commit": "411e09b969b1170a9f0c467558eb4c4c110d9c77", # Apr 4, 2017
    },


}
