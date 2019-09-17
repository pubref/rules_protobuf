load("//protobuf:internal/proto_compile.bzl", _proto_compile = "proto_compile")
load("//protobuf:internal/proto_language.bzl", _proto_language = "proto_language", _proto_language_deps = "proto_language_deps")
load("//protobuf:internal/proto_repositories.bzl", _proto_repositories = "proto_repositories")
load("//protobuf:internal/github_archive.bzl", _github_archive = "github_archive")
load("//protobuf:internal/proto_http_archive.bzl", _proto_http_archive = "proto_http_archive")
load("//protobuf:internal/proto_dependencies.bzl", _proto_dependencies = "proto_dependencies")

proto_compile = _proto_compile
proto_language = _proto_language
proto_language_deps = _proto_language_deps
proto_repositories = _proto_repositories
github_archive = _github_archive
proto_http_archive = _proto_http_archive
proto_dependencies = _proto_dependencies