BAZEL_BIN := $(shell bazel info bazel-bin)
JAVA_SOURCE_PATH := "java/org/pubref/rules_protobuf/examples/helloworld"
GO_SOURCE_PATH := "go"

# The java examples could also be run with 'bazel run ...', but the
# point is to demonstrate how to run it as an executable jar.
java_server:
	bazel build $(JAVA_SOURCE_PATH)/server:netty_server_deploy.jar && \
	java -jar $(BAZEL_BIN)/examples/helloworld/$(JAVA_SOURCE_PATH)/server/netty_server_deploy.jar

java_client:
	bazel build $(JAVA_SOURCE_PATH)/client:netty_client_deploy.jar && \
	java -jar $(BAZEL_BIN)/examples/helloworld/$(JAVA_SOURCE_PATH)/client/netty_client_deploy.jar

go_client:
	bazel run go/client

cpp_server:
	bazel run cpp/server

cpp_client:
	bazel run cpp/client
