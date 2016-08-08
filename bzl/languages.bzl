load("//bzl:cpp/descriptor.bzl", CPP = "DESCRIPTOR")
load("//bzl:go/descriptor.bzl", GO = "DESCRIPTOR")
load("//bzl:python/descriptor.bzl", PYTHON = "DESCRIPTOR")
load("//bzl:ruby/descriptor.bzl", RUBY = "DESCRIPTOR")

# Master list of supported languages keyed by their shortname.

LANGUAGES = {
    "cpp": CPP,
    "go": GO,
    "py": PYTHON,
    "ruby": RUBY,
}
