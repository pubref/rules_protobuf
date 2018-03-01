DEPS = {

    "protoc_gen_grpc_node": {
        "rule": "bind",
        "actual": "@com_github_grpc_grpc//:grpc_node_plugin",
    },

    "npm_protobuf_stack": {
        "rule": "npm_repository",
        "deps": {
            "async": "2.6.0",
            "google-protobuf": "3.5.0",
            "lodash": "4.17.5",
            "minimist": "1.2.0",
        },
        "sha256": "96242be14d18d9f1e81603502893545c7ca0fbcabcb9e656656cbcdda2b52bbb",
    },

    "npm_grpc": {
        "rule": "npm_repository",
        "deps": {
            "grpc": "1.0.0",
        },
        # Disabiling sha for this one as it will likely fail since the sha256 is
        # calculated after node-gyp runs and therefore platform dependent.
        #sha256 = "dcbc0f43a7eb5c52529ba35a4d455d61fcef49d2ced3229e821d4b07c5aaef9d",
    },

}
