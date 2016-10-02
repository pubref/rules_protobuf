const fs = require('fs')
const path = require('path')
const jspb = require('google-protobuf');
const grpc = require('grpc');
const messages = require('examples-helloworld-proto-node');
const services_path = path.dirname(require.resolve('examples-helloworld-proto-node'));
const services = require(services_path + '/helloworld_grpc_pb');

function main() {
  console.log("Running main");
  var cred = grpc.credentials.createInsecure()
  console.log(cred.constructor.classname)
  console.log("grpc.credentials: " + cred)
  var client = new services.GreeterClient('localhost:50051', cred);
  var user;
  if (process.argv.length >= 3) {
    user = process.argv[2];
  } else {
    user = 'world';
  }

  client.sayHello(request, function(err, response) {
    console.log('Greeting:', response.getMessage());
  });


  // var user = "Foo";
  // var request = new messages.HelloRequest();
  // request.setName(user);
  // console.log("Hello " + request.getName());

}

main();
