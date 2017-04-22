BAZEL := "bazel"

STARTUP_FLAGS += --output_base="$HOME/.cache/bazel"
STARTUP_FLAGS += --host_jvm_args=-Xmx500m
STARTUP_FLAGS += --host_jvm_args=-Xms500m
STARTUP_FLAGS += --batch
#STARTUP_FLAGS := ""

BUILD_FLAGS += --verbose_failures
BUILD_FLAGS += --spawn_strategy=standalone
BUILD_FLAGS += --genrule_strategy=standalone
BUILD_FLAGS += --local_resources=400,2,1.0
BUILD_FLAGS += --worker_verbose
BUILD_FLAGS += --strategy=Javac=worker
BUILD_FLAGS += --strategy=Closure=worker
BUILD_FLAGS += --experimental_repository_cache="$HOME/.bazel_repository_cache"

TESTFLAGS += $(BUILDFLAGS)
TEST_FLAGS += --test_output=errors
TEST_FLAGS += --test_strategy=standalone

BAZEL_BUILD := $(BAZEL) $(STARTFLAGS) $(BAZELFLAGS) build $(BUILDFLAGS)
BAZEL_TEST := $(BAZEL) $(STARTFLAGS) $(BAZELFLAGS) test $(TEST_FLAGS)

test_not_working_targets:
	$(BAZEL) test \
	//examples/wkt/cpp:wkt_test \
	//examples/helloworld/csharp/GreeterClient:GreeterClientTest \
	//examples/helloworld/csharp/GreeterServer:GreeterServerTest \

test_pip_depdendent_targets:
	$(BAZEL_TEST) \
	//examples/helloworld/python:test_greeter_server \

all: build test

build: go_package_build external_proto_library_build toffaletti_proto_fail_build
	$(BAZEL_BUILD) \
	//examples/extra_args:person_tar \
	//examples/helloworld/go/client \
	//examples/helloworld/go/server \
	//examples/helloworld/grpc_gateway:swagger \
	//examples/helloworld/node:client \
	//examples/helloworld/node:server \
	//tests/go_import_prefix:x \
	//tests/go_import_prefix:y \
	//tests/proto_file_in_subdirectory:baz_cc_proto \
	//tests/proto_file_in_subdirectory:baz_py_proto \
	//tests/with_grpc_false:cpp \
	//tests/with_grpc_false:java \
	//tests/with_grpc_false:protos \

test:
	$(BAZEL_TEST) \
	//examples/helloworld/closure:greeter_test \
	//examples/helloworld/cpp:test \
	//examples/helloworld/grpc_gateway:greeter_test \
	//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/client:netty_test \
	//examples/helloworld/java/org/pubref/rules_protobuf/examples/helloworld/server:netty_test \
	//examples/wkt/java:wkt_test \
	//examples/wkt/go:wkt_test \
	//tests/proto_file_in_subdirectory:test \

go_package_build:
	cd tests/go_package && $(BAZEL_BUILD) :main

external_proto_library_build:
	cd tests/external_proto_library && $(BAZEL_BUILD) :cc_gapi :go_gapi :java_gapi

toffaletti_proto_fail_build:
	cd tests/toffaletti_proto_fail && $(BAZEL_BUILD) :py_options_proto


fmt:
	buildifier WORKSPACE
	find bzl/build_file/ -name '*.BUILD' | xargs buildifier
	find third_party/ -name BUILD | xargs buildifier
	find examples/ -name BUILD | xargs buildifier
	find tests/ -name BUILD | xargs buildifier

replace:
	rpl -vvR -x'.md' -x'.bzl' -x'BUILD' -x'WORKSPACE' \
	'com_github_google_protobuf' \
	'com_google_protobuf' \
	protobuf/ objc/ grpc_gateway/ go/ examples/ cpp/
