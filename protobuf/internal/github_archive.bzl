load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def github_archive(name, org, repo, commit, **kwargs):
    url = "https://github.com/{org}/{repo}/archive/{commit}.zip".format(
        org = org,
        repo = repo,
        commit = commit,
    )
    strip_prefix = "{repo}-{commit}".format(
        repo = repo,
        commit = commit,
    )
    http_archive(name = name,
                 url = url,
                 strip_prefix = strip_prefix,
                 **kwargs)
