load("//bzl:repositories.bzl", "REPOSITORIES")
load("//bzl:languages.bzl", "LANGUAGES")
load("//bzl:compile.bzl", "implement")
load("//bzl:require.bzl", "require")
#load("//bzl:library.bzl", "implement")

proto_compile = implement(LANGUAGES.keys())
#proto_library = implement(LANGUAGES.keys())

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

  if python: load += ["py"]
  if ruby: load += ["ruby"]

  for name in load:
    lang = LANGUAGES[name]
    if not lang:
      fail("Unknown language " + name)
    requires = getattr(lang, "requires", [])
    for target in requires:
      require(target, context)
