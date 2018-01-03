# Standalone grpc gateway example

This subdirectory demonstrates a small example standalone application
for grpc_gateway.

Note: your proto file **MUST** contain a service definition and that
service **MUST** contain an annotation that tells `protoc-gen-grpc-gateway`
how to generate the proxy.  It will silently skip service definitions
that don't have an annotation.
