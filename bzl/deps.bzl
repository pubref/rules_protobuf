# ****************************************************************
# Master list of dependencies
# ****************************************************************

DEPS = {
    # Grpc repo is required by multiple languages
    "grpc": {
        "kind": "git_repository",
        "name": "com_github_grpc_grpc",
        "remote": "https://github.com/grpc/grpc.git",
        "init_submodules": True,
        "tag": "v0.15.2",
    },

    # libssl is required for c++ grpc where it is expected in
    # //external:libssl.  This can be either boringssl or openssl.
    "libssl": {
        "kind": "bind",
        "name": "libssl",
        "actual": "@boringssl//:ssl",
    },

    # Hooray! The boringssl team provides a "master-with-bazel" branch
    # with all BUILD files ready to go.  To update, pick the
    # newest-ish commit-id off that branch.
    "boringssl": {
        "kind": "git_repository",
        "name":  "boringssl", # use short version as this is what boringssl defines workspace as
        "remote":  "https://boringssl.googlesource.com/boringssl",
        "commit": "36b3ab3e5d3a4892444a698f7989f2150824d804", # Aug 3 2016
    },

    # C-library for zlib
    "zlib": {
        "kind": "new_git_repository",
        "name": "com_github_madler_zlib",
        "remote": "https://github.com/madler/zlib",
        "tag": "v1.2.8",
        "build_file": "//third_party/com_github_madler_zlib:BUILD",
    },

    # grpc++ expects //external:zlib
    "external_zlib": {
        "kind": "bind",
        "name": "zlib",
        "actual": "@com_github_madler_zlib//:zlib",
    },

    # grpc++ expecte
    # Protobuf required by grpc++
    "protobuf": {
        "kind": "git_repository",
        "name": "com_github_google_protobuf",
        "remote": "https://github.com/google/protobuf.git",
        "tag": "v3.0.0",
    },

    # grpc++ expects "//external:protobuf_clib"
    "external_protobuf_clib": {
        "kind": "bind",
        "name": "protobuf_clib",
        "actual": "@com_github_google_protobuf//:protobuf",
    },

    # grpc++ requires nanobp (and now has a BUILD file!)
    "nanopb": {
        "kind": "git_repository",
        "name": "com_github_nanopb_nanopb",
        "remote": "https://github.com/nanopb/nanopb.git",
        "commit": "0198210f2cc349e7bc5199e8db7f4afc8208d843", # Aug 2 2016
    },

    # grpc++ expects //external:nanopb
    "external_nanopb": {
        "kind": "bind",
        "name": "nanopb",
        "actual": "@com_github_nanopb_nanopb//:nanopb",
    },

    # Bind the executable cc_binary grpc plugin into //external:protoc_gen_grpc_cpp.  Expects
    # //external:protobuf_compiler.
    "external_protoc_gen_grpc_cpp": {
        "kind": "bind",
        "name": "protoc_gen_grpc_cpp",
        "actual": "@com_github_grpc_grpc//:grpc_cpp_plugin",
    },

    # Bind the protobuf proto_lib (protoc) into //external.  Required
    # for compiling the protoc_gen_grpc plugin
    "external_protobuf_compiler": {
        "kind": "bind",
        "name": "protobuf_compiler",
        "actual": "@com_github_google_protobuf//:protoc_lib",
    },

}

def require(target, opts={}):
    dep = DEPS.get(target)
    opt = opts.get(target) or {}
    verbose = opts.get("verbose")

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
        print("%s %s (@%s) with args %s" % (kind, target, name, args))

    rule(**args)
