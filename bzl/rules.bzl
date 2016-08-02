load("//bzl:go.bzl", "protoc_go", "rules_protobuf_go")
load("//bzl:java.bzl", "protoc_java", "rules_protobuf_java")
load("//bzl:protoc.bzl", "protoc", "rules_protobuf_protoc")

def rules_protobuf(
  with_protoc=True,
  with_cpp=False,
  with_go=False,
  with_java=False,
  with_js=False,
  with_python=False):

  if with_protoc:
    rules_protobuf_protoc()

  if with_go:
    #print("Loading go workspace dependencies...")
    rules_protobuf_go()
  if with_java:
    #print("Loading java workspace dependencies...")  
    rules_protobuf_java()
