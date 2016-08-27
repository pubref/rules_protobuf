load("@io_bazel_rules_go//go:def.bzl", "go_repositories")
load("//bzl:classes.bzl", "CLASSES")
load("//bzl:repositories.bzl", "REPOSITORIES")
load("//bzl:util.bzl", "require", "invoke")

def protobuf_repositories(
    extensions = [],
    overrides = {},
    verbose = 0,
    with_cpp=False,
    with_csharp=False,
    with_go=False,
    with_java=False,
    with_javanano=False,
    with_js=False,
    with_python=False,
    with_ruby=False,
    with_grpc_gateway=False,
):

  # Disabling skipping of grpc-related dependencies.  Adding this back
  # in will require the ability to write a configuration setting that
  # can be read later by the 'implement' function.
  with_grpc = True,

  # Generate a master list of repos, allowing user to override.
  repos = {}
  for k, v in REPOSITORIES.items():
    over = overrides.get(k)
    if over:
      repos[k] = v + over
    else:
      repos[k] = v

  # Config-like object.
  context = struct(
    repos = repos,
    verbose = verbose,
    options = {},
  )

  # Build a list of classes to boot dependencies for.
  classes = []

  if with_grpc_gateway:
    with_go = True
  if with_cpp:
    classes += ["cpp"]
  if with_csharp:
    classes += ["csharp"]
  if with_python:
    classes += ["python"]
  if with_go:
    classes += ["go"]
  if with_java:
    classes += ["java"]
  if with_js:
    classes += ["js"]
  if with_javanano:
    classes += ["javanano"]
  if with_grpc_gateway:
    classes += ["gateway"]
  if with_ruby:
    classes += ["ruby"]

  requires = [
    "protobuf",
    "external_protoc",
  ]

  # Compile deps list.
  for name in classes:
    lang = CLASSES[name]

    if not lang:
      fail("Unknown language " + name)

    if hasattr(lang, "protobuf"):
      requires += getattr(lang.protobuf, "requires", [])

    if with_grpc and hasattr(lang, "grpc"):
      requires += getattr(lang.grpc, "requires", [])

  # Require all specified deps.
  for target in requires:
    require(target, context)
