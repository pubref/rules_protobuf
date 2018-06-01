extern crate grpc;
extern crate helloworld;

use std::env;
use std::str::FromStr;

use helloworld::*;

fn parse_args() -> (String, u16) {
    let mut name = "world".to_owned();
    let mut port = 50051;
    for arg in env::args().skip(1) {
        if arg.starts_with("-p=") {
            port = u16::from_str(&arg[3..]).unwrap()
        } else {
            name = arg.to_owned();
        }
    }
    (name, port)
}

fn main() {
    let (name, port) = parse_args();
    let client = GreeterClient::new_plain("::1", port, Default::default()).unwrap();
    let mut req = HelloRequest::new();
    req.set_name(name);
    let resp = client.say_hello(grpc::RequestOptions::new(), req);
    println!("{:?}", resp.wait());
}
