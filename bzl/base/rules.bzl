load("//bzl:protoc.bzl", "PROTOC", "implement")
load("//bzl:util.bzl", "invoke")

def proto_library(
    name,
    deps = [],
    spec = [],
    imports = [],
    output_to_workspace = False,
    proto_compile = None,
    proto_compile_args = {},
    proto_deps = [],
    protoc = PROTOC,
    protos = [],
    srcs = [],
    verbose = 0,
    visibility = None,
    with_grpc = False,
    **kwargs):

  if not spec:
    fail("Language list specification required.", "spec")
  if not proto_compile:
    proto_compile = implement(spec)

  # Part 1: assemble argument for the proto compiler
  #
  args = {}
  args["name"] = name + ".pb"
  args["proto_deps"] = [d + ".pb" for d in proto_deps]
  args["imports"] = imports
  args["output_to_workspace"] = output_to_workspace
  args["protoc"] = protoc
  args["protos"] = protos
  args["verbose"] = verbose
  args["with_grpc"] = with_grpc

  for lang in spec:
    args["gen_" + lang.name] = True

  args = args + proto_compile_args

  # Part 2: generate code.
  proto_compile(**args)

  # Part 3: assemble arguments for the library rule(s).
  generated_srcs = []

  # By (strange) convention, last rule specified wins. In most cases
  # this is just one.
  rule = None

  for lang in spec:
    primary_output_suffix = invoke("get_primary_output_suffix", lang, args)
    generated_srcs += [name + primary_output_suffix]

    if hasattr(lang, "grpc"):
      deps += [str(Label(dep)) for dep in getattr(lang.grpc, "compile_deps", [])]
    elif hasattr(lang, "protobuf"):
      deps += [str(Label(dep)) for dep in getattr(lang.protobuf, "compile_deps", [])]

    if hasattr(lang, "library"):
      rule = lang.library

  deps = list(set(deps + proto_deps))
  srcs = list(set(srcs + generated_srcs))

  if verbose > 2:
    print("final set of library deps: %s" % (deps))

  # Part 4: compile generated code.
  if rule:
    rule(name = name, deps = deps, srcs = srcs, **kwargs)
