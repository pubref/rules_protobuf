load("//bzl:protoc/gen.bzl",
     common_attrs = "attrs",
     common_impl = "gen",
)


def attrs():
  attrs = common_attrs()
  attrs["gen_py"] = attr.bool(default = True)
  return attrs


gen = rule(
  implementation=common_impl,
  attrs = attrs(),
  output_to_genfiles=True,
)
