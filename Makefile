helloworld_server:
	bazel build //java/org/pubref/tools/bazel/protobuf/examples/helloworld/server:netty_server_deploy.jar && \
	java -jar bazel-bin/java/org/pubref/tools/bazel/protobuf/examples/helloworld/server/netty_server_deploy.jar

helloworld_client:
	bazel build //java/org/pubref/tools/bazel/protobuf/examples/helloworld/client:netty_client_deploy.jar && \
	java -jar bazel-bin/java/org/pubref/tools/bazel/protobuf/examples/helloworld/client/netty_client_deploy.jar

buildify_all:
	buildifier WORKSPACE
	find third_party/ -name BUILD | xargs buildifier
	find java/ -name BUILD | xargs buildifier
