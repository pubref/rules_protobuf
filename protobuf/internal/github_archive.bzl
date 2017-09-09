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
    if "build_file" in kwargs or "build_file_content" in kwargs:
        native.new_http_archive(name = name,
                                url = url,
                                strip_prefix = strip_prefix,
                                **kwargs)
    else:
        native.http_archive(name = name,
                            url = url,
                            strip_prefix = strip_prefix,
                            **kwargs)
