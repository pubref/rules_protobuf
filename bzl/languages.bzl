load("//bzl:python/descriptor.bzl", PYTHON = "DESCRIPTOR")
load("//bzl:ruby/descriptor.bzl", RUBY = "DESCRIPTOR")

# Master list of supported languages keyed by their shortname.

LANGUAGES = {
    "py": PYTHON,
    "ruby": RUBY,
}
