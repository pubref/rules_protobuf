## v0.8.0 (Wed Sep 6 2017)

This is a significant (possibly overreaching) update that brings grpc
support up to latest.  rules_protobuf should also load much faster
than previously.  Some of the names of external workspaces have
changed that may break your build (for example, string references such
as 'external/com_github_google_protobuf/src' should be migrated to
'external/com_google_protobuf/src' in an 'imports' attribute).

* Introduce cpp/grpc_repository.bzl to setup a custom @com_github_grpc_grpc
  external workspace (no longer using git_repository#init_submodules).
  This pulls down grpc/grpc from github as @com_github_grpc_grpc_base, sets
  up a mirrored external workspace in @com_github_grpc_grpc that symlinks
  to @com_github_grpc_grpc_base, then does a "git submodule the hard way" for
  c-ares, and installs a patched version of generate_cc.bzl.
* Rename repository @com_github_google_protobuf to @com_google_protobuf.
* Rename repository @com_github_grpc_grpc to @com_github_grpc_grpc.
* Rename repository @gtest to @com_google_googletest.
* Updated grpc/grpc to 1.6.1.
* Updated madler/zlib to 1.2.11.
* Updated boringssl to master-with-bazel Sep 2 2017.
* Updated nuget deps to 1.6.0.
* Adding binding to //external:protocol_compiler (that's what with grpc repo wants).
* Remove binding //external:protoc (now //external:protocol_compiler).
* Migrated all git_repository repository_rules to http_archive
  (faster).

## v0.7.2 (Fri Jul 14 2017)

* Updated boringssl to latest chromium-stable (@pcj)
* Updated grpc-java to 1.4.0 (@zhexuany)
* Fixed broken links in README (@mikesamuel)
* Improve gogo{fast,faster,slick}_proto_compile (@timpalpant)
* Support grpc_gateway 1.2 (@pcj)
* Improved grpc_gateway documentation (@prestonvanloon)
* Update grpc go t0 1.2.1 (@clownpriest)
* Overall documentation improvments (@cheister)
* Fixed require bug (@raraujosc)
* Upgrade gogo deps (@geeknoid)
* Java documentation improvements (@bzz)
* Add support for gogofast, gogofaster, and gogoslick (@douglas-reid)
* Add -request_context option to grpc_gateway_library (@pcj)
* Automatically export //java:grpc_compiletime_deps (@perezd)
* Add importmap to gogo_proto_library (@gsf)
* Documentation improvments (@Maverick-Crank-GRey)
* Improved python support (Nikos Michalakis)
* README update (@wiktortomczak)
