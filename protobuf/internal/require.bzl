load("//protobuf:internal/repositories.bzl", "REPOSITORIES")

def _load(target, repos, verbose):
    """Load external dependency during WORKSPACE loading.

    Args:
      context: The loading context

    Returns:
      the return value of the native repository rule.

    """

    dep = repos.get(target)

    # Is the dep defined?
    if not dep:
        fail("Undefined dependency: " + target)

    name = dep.get("name")
    kind = dep.get("kind")
    if not name:
        fail("Dependency target %s is missing required attribute 'name': " % target)
    if not kind:
        fail("Dependency target %s is missing required attribute 'kind': " % target)

    #print("dep: %s" % dep.items())

    # Does it already exist?
    defined = native.existing_rule(dep.get("name"))
    if defined:
        hkeys = ["sha256", "sha1", "tag"]
        # If it has already been defined and our dependency lists a
        # hash, do these match? If a hash mismatch is encountered, has
        # the user specifically granted permission to continue?
        for hkey in hkeys:
            expected = dep.get(hkey)
            actual = defined.get(hkey)
            if expected:
                if expected != actual:
                  fail("Namespace (%s) already exists in the "
                       + "workspace but %s=%s did not match "
                       + "the required value: %s.  Either remove it from your WORKSPACE or exclude=['%s'] it from loading."
                       % (target, dep.name, hkey, actual, expected, target))
                else:
                    if verbose:
                        print("Not reloading %s (@%s): %s matches %s" % (target, name, hkey, actual))
                    return

        # No kheys for this rule
        if verbose:
            print("Skipping reload of target %s (no hash keys %s)" % (target, hkeys))
        return

    if not hasattr(native, kind):
        fail("No native workspace rule named '%s' in dependency %s" % (kind, name))

    rule = getattr(native, kind)
    if not rule:
        fail("During require (%s), kind '%s' has no matching native rule" % (target, dep.kind))

    # Invoke the native rule with the unpacked arguments, without
    # special entries (those that have no corresponding representation
    # in the native struct)
    args = dict(dep.items())
    args.pop("kind")

    if verbose:
        #print("Load %s %s (@%s) with args %s" % (kind, target, name, args))
        print("Load %s (@%s)" % (target, name))

    return rule(**args)


def require(repositories = REPOSITORIES,
            overrides = {},
            excludes = [],
            requires = [],
            verbose = 0):
  repos = {}

  for k, v in repositories.items():
    override = overrides.get(k)
    if override:
      # Merge override properties
      repos[k] = v + override
    else:
      repos[k] = v

  for target in requires:
    if not target in excludes:
      _load(target, repos, verbose)
