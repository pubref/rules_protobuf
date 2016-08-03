def deps(
  omit_foo = True,
):

  if not omit_foo:
    foo()


def foo():
  native.git_repository(
    name = "foo",
    remote = "https://github.com/foo/foo.git",
    tag = "0.0",
  )
