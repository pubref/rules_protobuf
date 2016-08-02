load("//bzl:protoc/gen.bzl",
     common_impl = "gen",
     common_attrs = "attrs",
)

gen = rule(
  implementation=common_impl,
  attrs=common_attrs(),
  output_to_genfiles=True,
)
