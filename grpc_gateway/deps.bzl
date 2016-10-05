# ****************************************************************
# List of external dependencies
# ****************************************************************

DEPS = {

    "com_github_grpc_ecosystem_grpc_gateway": {
        "rule": "new_git_repository",
        "remote": "https://github.com/grpc-ecosystem/grpc-gateway.git",
        "commit": "ccd4e6b091a44f9f6b32848ffc63b3e8f8e26092",
        "build_file": str(Label("//protobuf:build_file/com_github_grpc_ecosystem_grpc_gateway.BUILD")),
    },

}
