load("//bzl:repositories.bzl", "REPOSITORIES")
load("//bzl:classes.bzl", "CLASSES")
load("//bzl:util.bzl", "require", "invoke")

def protobuf_repositories(
    with_protoc = True,
    with_cpp=False,
    with_go=False,
    with_java=False,
    with_javanano=False,
    with_js=False,
    with_python=False,
    with_ruby=False,

    with_grpc = False,
    verbose = False,
    extensions = [],
    overrides = {},
):


  repos = {}
  for k, v in REPOSITORIES.items():
    over = overrides.get(k)
    if over:
      repos[k] = v + over
    else:
      repos[k] = v

  context = struct(
    repos = repos,
    verbose = verbose,
    options = {},
  )

  classes = []
  requires = [
    "external_protoc",
  ]

  if with_cpp:
    classes += ["cpp"]
  if with_python:
    classes += ["py"]
  if with_go:
    classes += ["go"]
  if with_java:
    classes += ["java"]
  if with_javanano:
    classes += ["javanano"]

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
