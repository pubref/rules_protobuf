package main

import (
	"fmt"
	"github.com/golang/protobuf/jsonpb"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"strings"
	"testing"

	"github.com/grpc-ecosystem/grpc-gateway/runtime"
	greeter "github.com/pubref/rules_protobuf/examples/helloworld/go/server/greeter"
	pb "github.com/pubref/rules_protobuf/examples/helloworld/proto/go"
	gateway "github.com/pubref/rules_protobuf/examples/helloworld/grpc_gateway"
)

const (
	grpc_port = ":50051"
	http_port = ":8080"
)

func TestGreet(t *testing.T) {
	if testing.Short() {
		t.Skip()
		return
	}

	go startServer()
	go startGateway()

	testGreet(t)
}

func testGreet(t *testing.T) {

	url := fmt.Sprintf("http://localhost%s/v1/helloworld/sayhello", http_port)
	resp, err := http.Post(url, "application/json", strings.NewReader("{\"name\": \"foo\"}"))
	if err != nil {
		t.Errorf("http.Post(%q) failed with %v; want success", url, err)
		return
	}
	defer resp.Body.Close()
	buf, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		t.Errorf("iotuil.ReadAll(resp.Body) failed with %v; want success", err)
		return
	}

	if got, want := resp.StatusCode, http.StatusOK; got != want {
		t.Errorf("resp.StatusCode = %d; want %d", got, want)
		t.Logf("%s", buf)
	}

	var reply gateway.HelloReply
	if err := jsonpb.UnmarshalString(string(buf), &reply); err != nil {
		t.Errorf("jsonpb.UnmarshalString(%s, &reply) failed with %v; want success", buf, err)
		return
	}
	if got, want := reply.Message, "Hello foo"; got != want {
		t.Errorf("msg.message = %q; want %q", got, want)
	}
}

func startServer() {
	lis, err := net.Listen("tcp", grpc_port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterGreeterServer(s, &greeter.Server{}) //pb.Registergreeterserver
	s.Serve(lis)
}

func startGateway() error {
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	mux := runtime.NewServeMux()
	opts := []grpc.DialOption{grpc.WithInsecure()}
	err := gateway.RegisterGreeterHandlerFromEndpoint(ctx, mux, "localhost:50051", opts)
	if err != nil {
		return err
	}

	http.ListenAndServe(http_port, mux)
	return nil
}
