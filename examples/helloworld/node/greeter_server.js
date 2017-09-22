const grpc = require('grpc');
const messages = require('examples/helloworld/node/api_proto_js').api_pb;
const services = require('examples/helloworld/node/api_proto_js').api_grpc_pb;

/**
 * Implements the SayHello RPC method.
 */
function sayHello(call, callback) {
  var reply = new messages.HelloReply();
  reply.setMessage('Hello ' + call.request.getName());
  callback(null, reply);
}

/**
 * Starts an RPC server that receives requests for the Greeter service at the
 * sample server port
 */
function main() {
  var server = new grpc.Server();
  server.addService(services.GreeterService, { sayHello: sayHello });
  server.bind('0.0.0.0:50051', grpc.ServerCredentials.createInsecure());
  server.start();
}

main();
