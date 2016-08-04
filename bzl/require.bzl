load("//bzl:deps.bzl", "DEPS")

def require(target, opts={}):
    """Load external dependency during WORKSPACE loading.

    Args:
      target: the name of the target, as defined in deps.bzl
      opts: a dict having the same overall structure of those found in deps.
            One can override/skip loading of a target if "omit": True is set.
            TODO: merge/extend the dict to allow loading of alternative versions.
    """
    dep = DEPS.get(target)
    opt = opts.get(target) or {}
    verbose = opts.get("verbose")
    #verbose = True

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

    # Should it be omitted?
    if opt.get("omit"):
        #print("omit %s!" % target)
        return

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
                    if opt.grant_hermetic_leak:
                        return
                    else:
                        fail("During require (%s), namespace (%s) already exists in the "
                             + "workspace but the existing %s=%s did not match "
                             + "the required value: %s.  If you feel this is in error, "
                             + "set opts['%s'].grant_hermetic_leak = True" % (target, dep.name, hkey, actual, expected, target))
                else:
                    if verbose:
                        print("Not reloading %s (@%s): %s matches %s" % (target, name, hkey, actual))
                    return

        # No kheys for this rule
        if verbose:
            print("Skipping reload of target %s (no hash keys %s)" % (target, hkeys))
        return

    # If this dependency declares another one, require that one now.
    # OH_SNAP: recursion is not allowed in skylark.  Removing this
    # feature.
    #
    # requires = dep.get("require")
    # if (requires):
    #     for ext in requires:
    #         require(ext, opts)

    rule = getattr(native, kind)
    if not rule:
        fail("During require (%s), kind '%s' has no matching native rule" % (target, dep.kind))

    # Invoke the native rule with the unpacked arguments, without
    # special entries (those that have no corresponding representation
    # in the native struct)
    args = dict(dep.items())
    args.pop("kind")

    if verbose:
        print("Invoke %s %s (@%s) with args %s" % (kind, target, name, args))

    rule(**args)
