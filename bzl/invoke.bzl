def invokesuper(name, lang, builder):
    if hasattr(lang, "parent"):
        if hasattr(lang.parent, name):
            method = getattr(lang.parent, name)
            method(lang, builder)
        else:
            fail("Unknown method %s" % name)


def invoke(name, lang, builder):
    if hasattr(lang, name):
        method = getattr(lang, name)
        method(lang, builder)
        return

    # Unrolling to avoid recursion in skylark
    if hasattr(lang, "parent"):
        if hasattr(lang.parent, name):
            method = getattr(lang.parent, name)
            method(lang, builder)
        else:
            fail("Unknown method %s" % name)
