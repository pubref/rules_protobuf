extern crate grpc;
extern crate helloworld;

use std::env;

use helloworld::*;

fn main() {
    let name = env::args().nth(1).unwrap_or("world".to_owned());
    let client = GreeterClient::new_plain("::1", 50051, Default::default()).unwrap();
    let mut req = HelloRequest::new();
    req.set_name(name);
    let resp = client.say_hello(grpc::RequestOptions::new(), req);
    println!("{:?}", resp.wait());
}
