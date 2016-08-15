load("//bzl:base/class.bzl", BASE = "CLASS")
load("//bzl:cpp/class.bzl", CPP = "CLASS")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:python/class.bzl", PYTHON = "CLASS")
load("//bzl:ruby/class.bzl", RUBY = "CLASS")
load("//bzl:java/class.bzl", JAVA = "CLASS")
load("//bzl:javanano/class.bzl", JAVANANO = "CLASS")
load("//bzl:grpc_gateway/class.bzl", GRPC_GATEWAY = "CLASS")

CLASSES = {
    "base": BASE,
    "cpp": CPP,
    "grpc_gateway": GRPC_GATEWAY,
    "java": JAVA,
    "javanano": JAVANANO,
    "go": GO,
    "py": PYTHON,
    "ruby": RUBY,
}
