package main

// Purpose of this test is mainly that we can build/compile protobufs
// with go_package statements in both the root and non-root of the
// workspace.  The unit tests themselves are trivial.

import (
	"testing"
	"github.com/pubref/rules_protobuf/tests/go_package/root"
	"github.com/pubref/rules_protobuf/tests/go_package/subdir"
)

func TestRoot(t *testing.T) {
	name := "foo"
	p := &root.Dir{ Name: name }
	if p.GetName() != name {
		t.Errorf("Got: %s, Want: %s", p.GetName(), name)
	}
}

func TestSubdirRoot(t *testing.T) {
	name := "foo"
	p := &subdir.Dir{ Name: name }
	if p.GetName() != name {
		t.Errorf("Got: %s, Want: %s", p.GetName(), name)
	}
}
