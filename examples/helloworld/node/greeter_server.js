const path = require('path')
const messages = require('examples-helloworld-proto-node');
const services_path = path.dirname(require.resolve('examples-helloworld-proto-node'));
const services = require(services_path + '/helloworld_grpc_pb');

var grpc = require('grpc');

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
  server.addService(services.GreeterService, {sayHello: sayHello});
  server.bind('0.0.0.0:50051', grpc.ServerCredentials.createInsecure());
  server.start();
}

main();
