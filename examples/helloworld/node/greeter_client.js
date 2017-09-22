const grpc = require('grpc');
const messages = require('examples/helloworld/node/api_proto_js').api_pb;
const services = require('examples/helloworld/node/api_proto_js').api_grpc_pb;

function main() {
  var client = new services.GreeterClient(
    'localhost:50051',
    grpc.credentials.createInsecure());
  var request = new messages.HelloRequest();
  var user;
  if (process.argv.length >= 3) {
    user = process.argv[2];
  } else {
    user = 'world';
  }
  request.setName(user);
  client.sayHello(request, function(err, response) {
    if (err) {
      console.error('Error:', err);
    } else {
      console.log('Greeting:', response.getMessage());
    }
  });
}

main();
