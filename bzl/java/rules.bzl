load("//bzl:protoc/gen.bzl",
     common_attrs = "attrs",
     common_impl = "gen",
)


def attrs():
  """Returns: a map of rule attributes
  """
  attrs = common_attrs()
  attrs["gen_java"] = attr.bool(default = True)
  return attrs


gen = rule(
  implementation=common_impl,
  attrs = attrs(),
  output_to_genfiles=True,
  outputs = {
    "java_src": "%{name}.srcjar",
  },
)
