load("//protobuf:deps.bzl", PROTOBUF_DEPS = "DEPS")
load("//cpp:deps.bzl", CPP_DEPS = "DEPS")
load("//java:deps.bzl", JAVA_DEPS = "DEPS")
load("//node:deps.bzl", NODE_DEPS = "DEPS")
load("//csharp:deps.bzl", CSHARP_DEPS = "DEPS")
load("//go:deps.bzl", GO_DEPS = "DEPS")
load("//gogo:deps.bzl", GOGO_DEPS = "DEPS")
load("//grpc_gateway:deps.bzl", GRPC_GATEWAY_DEPS = "DEPS")

def _md_link(label, href):
    return "[%s](%s)" % (label, href)

def _md_workspace_label(name):
    return "**`@%s`**" % name

def _workspace_rule_link(rule):
    return _md_link(rule, "https://docs.bazel.build/versions/master/be/workspace.html#" + rule)

def _md_sha(d):
    sha256 = d.get("sha256")
    sha1 = d.get("sha1")
    if sha256:
        return "sha256:%s" % sha256[0:12]
    elif sha1:
        return "sha1:%s" % sha1[0:6]
    else:
        return "(no hash provided)"

def _npm_link(label, pkg):
    return _md_link(label, "https://npmjs.org/package/%s" % pkg)

def _nuget_link(label, pkg):
    return _md_link(label, "https://www.nuget.org/packages/%s" % pkg)

def _md_rule_bind(rule, name, d):
    return [
        _workspace_rule_link(rule),
        _md_workspace_label(name),
        "`//external:%s` (`%s`)" % (name, d["actual"]),
    ]

def _md_rule_http_archive(rule, name, d):
    url = d["url"]
    return [
        _workspace_rule_link(rule),
        _md_workspace_label(name),
        _md_link(_md_sha(d), url),
    ]

def _md_rule_http_file(rule, name, d):
    return _md_rule_http_archive(rule, name, d)

def _md_rule_maven_jar(rule, name, d):
    artifact = d["artifact"]
    url = d.get("repository") or "http:repo1.maven.org/maven2/"
    parts = artifact.split(":")
    org = parts[0].replace(".", "/")
    url += "/".join([org, parts[1], parts[2]])
    sha1 = d.get("sha1") or "?"
    return [
        _workspace_rule_link(rule),
        _md_workspace_label(name),
        _md_link("%s" % (artifact), url) + " (%s)" % sha1[0:6],
    ]

def _md_rule_go_repository(rule, name, d):
    importpath = d["importpath"];
    url = "https://%s/" % (importpath)
    key = d.get("commit") or d.get("tag") or "(no hash key listed)"
    return [
        _md_link(rule, "https://github.com/bazelbuild/rules_go#go_repository"),
        _md_workspace_label(name),
        _md_link(importpath, url),
    ]

def _md_rule_nuget_package(rule, name, d):
    return [
        _md_link(rule, "https://github.com/bazelbuild/rules_dotnet#" + rule),
        _md_workspace_label(name),
        _nuget_link("%s@%s" % (d["package"], d["version"]), d["package"])
    ]

def _md_rule_npm_repository(rule, name, d):
    deps = d["deps"]
    return [
        _md_link(rule, "https://github.com/pubref/rules_node#npm_repository"),
        _md_workspace_label(name),
        ", ".join([_npm_link(pkg + "@" + deps[pkg], pkg) for pkg in deps.keys()]),
    ]

def _md_rule_generic(rule, name, d):
    return [
        rule,
        _md_workspace_label(name),
        ""
    ]

def _md_rule(rule, name, d):
    if rule == 'bind':
        return _md_rule_bind(rule, name, d)
    elif rule == 'http_archive' or rule == 'new_http_archive':
        return _md_rule_http_archive(rule, name, d)
    elif rule == 'http_file':
        return _md_rule_http_file(rule, name, d)
    elif rule == 'maven_jar':
        return _md_rule_maven_jar(rule, name, d)
    elif rule == 'go_repository':
        return _md_rule_go_repository(rule, name, d)
    elif rule == 'npm_repository':
        return _md_rule_npm_repository(rule, name, d)
    elif rule == 'nuget_package' or rule == 'new_nuget_package':
        return _md_rule_nuget_package(rule, name, d)
    else:
        return _md_rule_generic(rule, name, d)

def _md_section(ctx, label, deps):
    lines = []
    lines.append("## %s" % label)
    lines.append("")
    lines.append("| Rule | Workspace | Detail |")
    lines.append("| ---: | :--- | :--- |")
    for name in deps.keys():
        d = deps[name]
        lines.append("| " + " | ".join(_md_rule(d["rule"], name, d)) + " |")
    lines.append("")
    return lines

def _md(ctx):
    lines = []
    lines.append("# Language dependencies for rules_protobuf")
    lines.append("To update this list, `bazel build @org_pubref_rules_protobuf//:deps && cp bazel-bin/DEPENDENCIES.md .`")
    lines.append("")
    lines += _md_section(ctx, "Protobuf", PROTOBUF_DEPS)
    lines += _md_section(ctx, "C++", CPP_DEPS)
    lines += _md_section(ctx, "Java", JAVA_DEPS)
    lines += _md_section(ctx, "C#", CSHARP_DEPS)
    lines += _md_section(ctx, "Go", GO_DEPS)
    lines += _md_section(ctx, "Gogo", GOGO_DEPS)
    lines += _md_section(ctx, "Grpc Gateway", GRPC_GATEWAY_DEPS)
    lines += _md_section(ctx, "Node", NODE_DEPS)
    return "\n".join(lines)

def _proto_dependencies_impl(ctx):
    files = [];

    if (ctx.attr.format == "markdown"):
        md_file = ctx.new_file("DEPENDENCIES.md")
        ctx.file_action(output = md_file,
                        content = _md(ctx),
                        executable = True)
        files.append(md_file)
    else:
        fail("Unknown output format: %r" % ctx.attr.format)

    return struct(
        files = depset(files),
    )

proto_dependencies = rule(
    implementation = _proto_dependencies_impl,
    attrs = {
        "format": attr.string(
            default = "markdown",
        ),
    }
)
