package main

import (
	"log"

	// The expected import for a proto file having the go_package
	// option 'pubref.org/test/app'.  However, although protoc
	// generates the file in this location, rules_go sets up the
	// compilation directory for the message_proto target using
	// the go_prefix from the workspace //:BUILD file (thus, the
	// go_package option is washed away).
	//
	// rules_protobuf copies the location of the actual generated
	// file output to the one expected by rules_go.  Thus, the
	// actual import path must match the same semantics of other
	// go proto imports, (GO_PREFIX/LABEL_PACKAGE/LABEL_NAME).
	//
	// This probably will break with protos that have complex
	// import dependencies that require the go_package option.

	// EXPECTED
	//pb "proto/pubref.org/test/app/config_proto"

	// ACTUAL
	proto "github.com/pubref/rules_protobuf/tests/go_package/proto/config_go_proto"
	//     |                                                 |     |
	//     ^ go_prefix                                       |     |
	//                                                       ^ label.package
	//                                                             |
	//                                                             ^ label.name

	// ACTUAL
	root "github.com/pubref/rules_protobuf/tests/go_package/file_in_package_root"
	//   |                                                 ||
	//   ^ go_prefix                                       ||
	//                                                     ^ label.package
	//                                                      |
	//                                                      ^ label.name

)

func main() {
	app := &root.App{Name: "MyApp"}
	config := &proto.Config{Label: "Hello"}
	log.Printf("App '%s' has config label: %s", app.Name, config.Label)
}
