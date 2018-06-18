def _proto_language_impl(ctx):
    #print("pb_compile_deps %s" % ctx.attr.pb_compile_deps)
    #print("pb_compile_deps files %s" % ctx.files.pb_compile_deps)
    return struct(
        proto_language = struct(
            name = ctx.label.name,
            output_to_workspace = ctx.attr.output_to_workspace,
            output_to_jar = ctx.attr.output_to_jar,
            output_to_library = ctx.attr.output_to_library,
            output_to_libdir = ctx.attr.output_to_libdir,
            output_file_style = ctx.attr.output_file_style,
            supports_pb = ctx.attr.supports_pb,
            pb_plugin_implements_grpc = ctx.attr.pb_plugin_implements_grpc,
            pb_file_extensions = ctx.attr.pb_file_extensions,
            pb_options = ctx.attr.pb_options,
            pb_imports = ctx.attr.pb_imports,
            pb_inputs = ctx.files.pb_inputs,
            pb_outputs = ctx.attr.pb_outputs,
            pb_plugin_name = ctx.attr.pb_plugin_name,
            pb_plugin = ctx.executable.pb_plugin,
            pb_compile_deps = ctx.files.pb_compile_deps,
            pb_runtime_deps = ctx.files.pb_runtime_deps,
            supports_grpc = ctx.attr.supports_grpc or ctx.attr.pb_plugin_implements_grpc,
            grpc_file_extensions = ctx.attr.grpc_file_extensions,
            grpc_options = ctx.attr.grpc_options,
            grpc_imports = ctx.attr.grpc_imports,
            grpc_inputs = ctx.files.grpc_inputs,
            grpc_plugin_name = ctx.attr.grpc_plugin_name,
            grpc_plugin = ctx.executable.grpc_plugin,
            grpc_compile_deps = ctx.files.grpc_compile_deps,
            grpc_runtime_deps = ctx.files.grpc_runtime_deps,
            go_package = ctx.attr.go_package,
            go_importpath = ctx.attr.go_importpath,
            importmap = ctx.attr.importmap,
        ),
    )


proto_language_attrs = {
    "output_to_workspace": attr.bool(),
    "output_to_jar": attr.bool(),
    "output_to_library": attr.bool(),
    "output_to_libdir": attr.bool(),
    "output_file_style": attr.string(),

    "supports_pb": attr.bool(default = True),
    "pb_file_extensions": attr.string_list(),
    "pb_options": attr.string_list(),
    "pb_inputs": attr.label_list(),
    "pb_imports": attr.string_list(),
    "pb_outputs": attr.string_list(),
    "pb_plugin_name": attr.string(),
    "pb_plugin": attr.label(
        executable = True,
        cfg = "host",
    ),
    "pb_compile_deps": attr.label_list(),
    "pb_runtime_deps": attr.label_list(),
    "pb_plugin_implements_grpc": attr.bool(),
    "supports_grpc": attr.bool(default = False),
    "grpc_file_extensions": attr.string_list(),
    "grpc_options": attr.string_list(),
    "grpc_imports": attr.string_list(),
    "grpc_inputs": attr.label_list(),
    "grpc_plugin_name": attr.string(),
    "grpc_plugin": attr.label(
        executable = True,
        cfg = "host",
    ),
    "grpc_compile_deps": attr.label_list(),
    "grpc_runtime_deps": attr.label_list(),
    "go_importpath": attr.string(
    ),
    "go_package": attr.string(),
    "importmap": attr.string_dict(),
}


proto_language = rule(
    implementation = _proto_language_impl,
    attrs = proto_language_attrs,
)

def _proto_language_deps_impl(ctx):
    files = []
    exts = ctx.attr.file_extensions

    for dep in ctx.attr.langs:
        lang = dep.proto_language
        if ctx.attr.compile_deps:
            files += lang.pb_compile_deps
            if lang.supports_grpc and ctx.attr.with_grpc:
                files += lang.grpc_compile_deps
        if ctx.attr.runtime_deps:
            files += lang.pb_runtime_deps
            if lang.supports_grpc and ctx.attr.with_grpc:
                files += lang.grpc_runtime_deps

    deps = []
    for file in files:
        for ext in exts:
            if file.path.endswith(ext):
                deps.append(file)

    return struct(
        files = depset(deps),
    )

proto_language_deps = rule(
    implementation = _proto_language_deps_impl,
    attrs = {
        "langs": attr.label_list(
            providers = ["proto_language"],
            mandatory = True,
        ),
        "with_grpc": attr.bool(default = True),
        "file_extensions": attr.string_list(mandatory = True),
        "compile_deps": attr.bool(default = True),
        "runtime_deps": attr.bool(default = False),
    }
)
"""Aggregates the deps named in pb_ and grpc_ proto_languages.
"""
