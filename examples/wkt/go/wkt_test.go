package wkt_test

import (
	"testing"
	wkt "github.com/pubref/rules_protobuf/examples/wkt/go"
	fd "github.com/golang/protobuf/protoc-gen-go/descriptor"
)


func TestWkt(t *testing.T) {
	filename := "wkt.proto"

	message := &wkt.Message{
		Id: "foo",
		File: &fd.FileDescriptorProto{
			Name: &filename,
		},
	}

	if message.Id != "foo" {
		t.Error("Expected foo, got ", message.Id)
	}

	if *message.File.Name != filename {
		t.Error("Expected %s, got %s", filename, message.File.Name)
	}
}
