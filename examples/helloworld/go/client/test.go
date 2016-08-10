package main

import (
	"testing"
	"log"
	"os"

	"golang.org/x/net/context"
	"google.golang.org/grpc"

	pb "github.com/pubref/rules_protobuf/examples/helloworld/proto/go"
)

const (
	address     = "localhost:50051"
	defaultName = "world"
)

func TestClient(t *testing.T) {
	// Set up a connection to the server.
	conn, err := grpc.Dial(address, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	c := pb.NewGreeterClient(conn)
	// Contact the server and print out its response.
	name := defaultName
	if len(os.Args) > 1 {
		name = os.Args[1]
	}
	r, err := c.SayHello(context.Background(), &pb.HelloRequest{Name: name})
	if err != nil {
		log.Fatalf("could not greet: %v", err)
	}
	log.Printf("Greeting: %s", r.Message)
}
