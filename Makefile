BAZEL := "bazel"

STARTUP_FLAGS += --output_base="$HOME/.cache/bazel"
STARTUP_FLAGS += --host_jvm_args=-Xmx500m
STARTUP_FLAGS += --host_jvm_args=-Xms500m
STARTUP_FLAGS += --batch

BUILD_FLAGS += --verbose_failures
BUILD_FLAGS += --spawn_strategy=standalone
BUILD_FLAGS += --genrule_strategy=standalone
BUILD_FLAGS += --local_resources=400,2,1.0
BUILD_FLAGS += --worker_verbose
BUILD_FLAGS += --strategy=Javac=worker
BUILD_FLAGS += --strategy=Closure=worker
#BUILD_FLAGS += --experimental_repository_cache="$HOME/.bazel_repository_cache"

TESTFLAGS += $(BUILDFLAGS)
TEST_FLAGS += --test_output=errors
TEST_FLAGS += --test_strategy=standalone

BAZEL_BUILD := $(BAZEL) $(STARTFLAGS) $(BAZELFLAGS) build $(BUILDFLAGS)
BAZEL_TEST := $(BAZEL) $(STARTFLAGS) $(BAZELFLAGS) test $(TEST_FLAGS)
#BAZEL_BUILD := $(BAZEL) build
#BAZEL_TEST := $(BAZEL) test

test_not_working_targets:
	$(BAZEL) test \
	//examples/helloworld/node:client \
	//examples/helloworld/node:server \
	//examples/helloworld/csharp/GreeterClient:GreeterClientTest \

test_not_working_in_travis_targets:
	$(BAZEL) test \
	//examples/helloworld/csharp/GreeterClient:GreeterClientTest \
	//examples/helloworld/grpc_gateway:greeter_test \

# Python targets are not working (pip grpcio only compatible with 3.1.x)
test_pip_dependent_targets:
	$(BAZEL_TEST) \
	//examples/helloworld/python:test_greeter_server \

test_gogo:
	cd tests/gogo && $(BAZEL_TEST) :gogo_test

all: build test

build: external_proto_library_build workspace_root_build
	$(BAZEL_BUILD) \
	//examples/extra_args:person_tar \
	//examples/helloworld/node:client \
	//examples/helloworld/node:server \
	//examples/helloworld/go/client \
	//examples/helloworld/go/server \
	//examples/helloworld/grpc_gateway:swagger \
	//tests/proto_file_in_subdirectory:protolib \
	//tests/with_grpc_false:protos \
	//tests/with_grpc_false:cpp \
	//tests/with_grpc_false:java \
	//tests/generated_proto_file:* \
	//tests/custom_go_importpath:* \

test: test_pip_dependent_targets test_gogo
	$(BAZEL_TEST) \
	//examples/helloworld/cpp:test \
	//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/client:netty_test \
	//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/server:netty_test \
	//examples/wkt/go:wkt_test \
	//tests/proto_file_in_subdirectory:test \
	//examples/helloworld/closure:greeter_test \


external_proto_library_build:
	cd tests/external_proto_library && $(BAZEL_BUILD) :cc_gapi :go_gapi :java_gapi

workspace_root_build:
	cd tests/build_in_workspace_root && $(BAZEL_BUILD) :bar_proto
fmt:
	buildifier WORKSPACE
	buildifier BUILD
	find closure/ -name BUILD | xargs buildifier
	find cpp/ -name BUILD | xargs buildifier
	find csharp/ -name BUILD | xargs buildifier
	find examples/ -name BUILD | xargs buildifier
	find go/ -name BUILD | xargs buildifier
	find gogo/ -name BUILD | xargs buildifier
	find grpc_gateway/ -name BUILD | xargs buildifier
	find node/ -name BUILD | xargs buildifier
	find objc/ -name BUILD | xargs buildifier
	find protobuf/ -name BUILD | xargs buildifier
	find python/ -name BUILD | xargs buildifier
	find ruby/ -name BUILD | xargs buildifier
	find tests/ -name BUILD | xargs buildifier
