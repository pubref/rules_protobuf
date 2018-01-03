package main

import (
	"github.com/grpc-ecosystem/grpc-gateway/runtime"
	"github.com/pubref/rules_protobuf/greeter"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"log"
	"net/http"
)

func main() {
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	mux := runtime.NewServeMux()
	opts := []grpc.DialOption{grpc.WithInsecure()}
	err := greeter.RegisterGreeterHandlerFromEndpoint(ctx, mux, "localhost:9090", opts)
	if err != nil {
		log.Fatal(err)
	}

	http.ListenAndServe(":8080", mux)
}


