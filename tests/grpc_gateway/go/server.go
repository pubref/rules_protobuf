
package main

import (
	"fmt"
	"log"
	"net"
	"google.golang.org/grpc"
	"golang.org/x/net/context"
	"github.com/pubref/rules_protobuf/greeter"
)

func main() {
	sopts := []grpc.ServerOption{}
	sopts = append(sopts, grpc.UnaryInterceptor(handleUnaryRequest))
	grpcServer := grpc.NewServer(sopts...)

	greeter.RegisterGreeterServer(grpcServer, &GreeterService{})

	lis, err := net.Listen("tcp", "localhost:9090")
	if err != nil {
		log.Fatalf("failed to bind: %v", err)
	}	
	grpcServer.Serve(lis)
}

func handleUnaryRequest(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
	log.Printf("Unary Request %s", info.FullMethod)
	return handler(ctx, req)
}


type GreeterService struct {
}

func (s *GreeterService) SayHello(ctx context.Context, request *greeter.HelloRequest) (*greeter.HelloReply, error) {
	return &greeter.HelloReply{
		Message: fmt.Sprintf("Hello %s!", request.Name),
	}, nil
}
