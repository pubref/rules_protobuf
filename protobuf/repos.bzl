def protobuf_repos(
  omit_protobuf_java=False,
  omit_protoc_linux_x86_64=False,
  omit_protoc_macosx=False):
  if not omit_protobuf_java:
    protobuf_java()
  if not omit_protoc_linux_x86_64:
    protoc_linux_x86_64()
  if not omit_protoc_macosx:
    protoc_macosx()

# MAINTAINERS
#
# 1. Please sort everything in this file.
#
# 2. Every external rule must have a SHA checksum.
#
# 3. Use http:// URLs since we're relying on the checksum for security.
#
# 4. Files must be mirrored to servers operated by Google SREs. This minimizes
#    the points of failure. It also minimizes the probability failure. For
#    example, if we assumed all external download servers were equal, had 99.9%
#    availability, and uniformly distributed downtime, that would put the
#    probability of an install working at 97.0% (0.999^30). Google static
#    content servers should have 99.999% availability, which *in theory* means
#    rules will install without any requests failing 99.9% of the time.
#

# def protobuf_java():
#   native.maven_jar(
#       name = "protobuf_java",
#       artifact = "com.google.protobuf:protobuf-java:3.0.0-beta-3",
#       sha1 = "ed8c2f9a63cfa770292f8173fd0172bdaa014fe3",
#       server = "closure_maven_server",
#   )

def protobuf_java():
  native.maven_jar(
      name = "com_google_protobuf_protobuf_java",
      artifact = "com.google.protobuf:protobuf-java:jar:3.0.0",
      #sha1 = "cd049bdc1680b9419359a73be694bac35a12942c",
      sha1 = "6d325aa7c921661d84577c0a93d82da4df9fa4c8",
  )

def protoc_linux_x86_64():
  native.http_file(
      name = "pubref_rules_protobuf_protoc_linux_x86_64",
      url = "http://bazel-mirror.storage.googleapis.com/github.com/google/protobuf/releases/download/v3.0.0-beta-3/protoc-3.0.0-beta-3-linux-x86_64.zip",
      sha256 = "48c592c6272e2a5043de792ff00ff162fe6f9bebd60147b05888b08f8d0e434b",
  )

def protoc_macosx():
  native.http_file(
      name = "pubref_rules_protobuf_protoc_macosx",
      url = "http://bazel-mirror.storage.googleapis.com/github.com/google/protobuf/releases/download/v3.0.0-beta-3/protoc-3.0.0-beta-3-osx-x86_64.zip",
      sha256 = "b009b2b433affcf00dbe645d0637139f9a6c1e38c2c7d4cc99c30919f5c2eaac",
  )
