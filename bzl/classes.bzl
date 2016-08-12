load("//bzl:base/class.bzl", BASE = "CLASS")
load("//bzl:cpp/class.bzl", CPP = "CLASS")
load("//bzl:go/class.bzl", GO = "CLASS")
load("//bzl:python/class.bzl", PYTHON = "CLASS")
load("//bzl:ruby/class.bzl", RUBY = "CLASS")
load("//bzl:java/class.bzl", JAVA = "CLASS")
load("//bzl:javanano/class.bzl", JAVANANO = "CLASS")

CLASSES = {
    "base": BASE,
    "cpp": CPP,
    "java": JAVA,
    "javanano": JAVANANO,
    "go": GO,
    "py": PYTHON,
    "ruby": RUBY,
}
