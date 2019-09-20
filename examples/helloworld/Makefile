BAZEL_BIN := $(shell bazel info bazel-bin)
GO_SOURCE_PATH := "go"

go_client:
	bazel run go/client

go_server:
	bazel build go/server && $(BAZEL_BIN)/examples/helloworld/go/server/server

curl_post:
	curl -X POST -k http://localhost:8080/v1/helloworld/sayhello -d '{"name": "gRPC-gateway!"}'
