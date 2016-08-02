BAZEL_BIN := $(shell bazel info bazel-bin)
JAVA_SOURCE_PATH := "java/org/pubref/rules_protobuf/examples/helloworld"
GO_SOURCE_PATH := "go"

netty_server:
	bazel build $(JAVA_SOURCE_PATH)/server:netty_server_deploy.jar && \
	java -jar $(BAZEL_BIN)/examples/helloworld/$(JAVA_SOURCE_PATH)/server/netty_server_deploy.jar

netty_client:
	bazel build $(JAVA_SOURCE_PATH)/client:netty_client_deploy.jar && \
	java -jar $(BAZEL_BIN)/examples/helloworld/$(JAVA_SOURCE_PATH)/client/netty_client_deploy.jar

go_client:
	bazel run $(GO_SOURCE_PATH)/client && \
	java -jar $(BAZEL_BIN)/examples/helloworld/$(JAVA_SOURCE_PATH)/client/netty_client_deploy.jar
