
package main

import (
	"github.com/pubref/rules_protobuf/tests/gogo/api"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"log"
	"net"
)

const (
	port = ":50051"
)

type Server struct{}

func (s *Server) Get(ctx context.Context, req *api.Request) (*api.Response, error) {
	return &api.Response{Message: "Hello " + req.Name}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	server := grpc.NewServer()
	api.RegisterApiServer(server, &Server{})
	log.Printf("Server listening on port %s\n", port)
	server.Serve(lis)
}
