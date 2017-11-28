
package main

import (
	"github.com/pubref/rules_protobuf/tests/gogo/api"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"log"
	"os"
)

const (
	address = "localhost:50051"
)

func main() {
	log.Printf("Client attempting gRPC request to %s\n", address)
	
	conn, err := grpc.Dial(address, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()

	client := api.NewApiClient(conn)

	
	name := "foo"
	if len(os.Args) > 1 {
		name = os.Args[1]
	}

	r, err := client.Get(context.Background(), &api.Request{Name: name})
	if err != nil {
		log.Fatalf("could not make request: %v", err)
	}

	log.Printf("API Response: %s", r.Message)
}
