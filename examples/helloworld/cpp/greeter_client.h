#ifndef GREETER_CLIENT_H
#define GREETER_CLIENT_H

#include <memory>
#include <string>
#include <grpc++/grpc++.h>

#include "examples/helloworld/proto/helloworld.pb.h"
#include "examples/helloworld/proto/helloworld.grpc.pb.h"

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;
using helloworld::HelloRequest;
using helloworld::HelloReply;
using helloworld::Greeter;

class GreeterClient {
 public:
  GreeterClient(std::shared_ptr<Channel> channel);
  // Assambles the client's payload, sends it and presents the
  // response back from the server.
  std::string SayHello(const std::string& user);

 private:
  std::unique_ptr<Greeter::Stub> stub_;
};

#endif
