load("//bzl:repositories.bzl", "REPOSITORIES")
load("//bzl:classes.bzl", "CLASSES")
load("//bzl:util.bzl", "require", "invoke")

def protobuf_repositories(
    protoc = True,
    cpp=False,
    go=False,
    java=False,
    js=False,
    python=False,
    ruby=False,

    with_grpc = False,
    verbose = False,
    extensions = [],
    overrides = {},
):

  context = struct(
    repos = REPOSITORIES,
    verbose = verbose,
    options = {},
  )

  classes = []
  requires = []

  if cpp:
    classes += ["cpp"]
  if python:
    classes += ["py"]
  if go:
    classes += ["go"]
  if java:
    classes += ["java"]

  for name in classes:
    lang = CLASSES[name]

    if not lang:
      fail("Unknown language " + name)

    if not hasattr(lang, "protobuf"):
      fail("Required struct 'protobuf' missing in language %s" % lang.name)
    requires += getattr(lang.protobuf, "requires", [])

    if with_grpc and hasattr(lang, "grpc"):
      requires += getattr(lang.grpc, "requires", [])

  for target in requires:
    require(target, context)
