load("//bzl:repositories.bzl", "REPOSITORIES")
load("//bzl:languages.bzl", "LANGUAGES")
load("//bzl:compile.bzl", "implement_compile", "implement_library")
load("//bzl:require.bzl", "require")

proto_compile = implement_compile(LANGUAGES.keys())
proto_library = implement_library(LANGUAGES.keys())

def protobuf_repositories(
    protoc = True,
    cpp=False,
    go=False,
    java=False,
    js=False,
    python=False,
    ruby=False,

    verbose = False,
    extensions = [],
    overrides = {},
):

  context = struct(
    repos = REPOSITORIES,
    verbose = verbose,
    options = {},
  )

  load = []

  if cpp: load += ["cpp"]
  if python: load += ["py"]
  if ruby: load += ["ruby"]
  if go: load += ["go"]

  for name in load:
    lang = LANGUAGES[name]
    if not lang:
      fail("Unknown language " + name)
    requires = getattr(lang, "requires", [])
    for target in requires:
      require(target, context)
