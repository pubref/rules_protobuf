load("//bzl:protoc.bzl", "protoc_attrs", "protoc_impl")

"""Utilities for building Java Protocol Buffers.
"""

# ****************************************************************
# Build Rule Definitions
# ****************************************************************

def _protoc_java_attrs():
  """Returns: a map of rule attributes
  """
  attrs = protoc_attrs()
  attrs["gen_java"] = attr.bool(default = True)
  return attrs

protoc_java = rule(
  implementation=protoc_impl,
  outputs = {
    "java_src": "%{name}.srcjar",
  },
  attrs = _protoc_java_attrs(),
  output_to_genfiles=True,
)

# ****************************************************************
# Workspace Dependency Management
# ****************************************************************

def rules_protobuf_java(
  omit_grpc=False,

  omit_com_google_auth_google_auth_library_credentials=False,
  omit_com_google_code_gson_gson=False,
  omit_com_google_code_findbugs_jsr305=False,
  omit_com_google_guava_guava=False,
  omit_com_google_protobuf_protobuf_java=False,
  omit_com_google_protobuf_protobuf_java_util=False,
  omit_com_google_protobuf_nano_protobuf_javanano=False,

  omit_com_squareup_okhttp_okhttp=False,
  omit_com_squareup_okio_okio=False,

  omit_io_grpc_grpc_all=False,
  omit_io_grpc_grpc_auth=False,
  omit_io_grpc_grpc_core=False,
  omit_io_grpc_grpc_netty=False,
  omit_io_grpc_grpc_okhttp=False,
  omit_io_grpc_grpc_protobuf=False,
  omit_io_grpc_grpc_protobuf_lite=False,
  omit_io_grpc_grpc_protobuf_nano=False,
  omit_io_grpc_grpc_stub=False,

  omit_io_netty_netty_buffer=False,
  omit_io_netty_netty_codec=False,
  omit_io_netty_netty_codec_http=False,
  omit_io_netty_netty_codec_http2=False,
  omit_io_netty_netty_common=False,
  omit_io_netty_netty_handler=False,
  omit_io_netty_netty_resolver=False,
  omit_io_netty_netty_transport=False,

  omit_protoc_gen_grpc_java_linux_x86_64=False,
  omit_protoc_gen_grpc_java_macosx=False,
):

  if not omit_com_google_protobuf_protobuf_java:
    com_google_protobuf_protobuf_java()
  if not omit_com_google_protobuf_protobuf_java_util:
    com_google_protobuf_protobuf_java_util()

  if not omit_protoc_gen_grpc_java_linux_x86_64:
    protoc_gen_grpc_java_linux_x86_64()
  if not omit_protoc_gen_grpc_java_macosx:
    protoc_gen_grpc_java_macosx()

  if not omit_grpc:

    if not omit_com_google_auth_google_auth_library_credentials:
      com_google_auth_google_auth_library_credentials()
    if not omit_com_google_code_gson_gson:
      com_google_code_gson_gson()
    if not omit_com_google_code_findbugs_jsr305:
      com_google_code_findbugs_jsr305()
    if not omit_com_google_guava_guava:
      com_google_guava_guava()
    if not omit_com_google_protobuf_nano_protobuf_javanano:
      com_google_protobuf_nano_protobuf_javanano()

    if not omit_com_squareup_okhttp_okhttp:
      com_squareup_okhttp_okhttp()
    if not omit_com_squareup_okio_okio:
      com_squareup_okio_okio()

    if not omit_io_grpc_grpc_auth:
      io_grpc_grpc_auth()
    if not omit_io_grpc_grpc_core:
      io_grpc_grpc_core()
    if not omit_io_grpc_grpc_netty:
      io_grpc_grpc_netty()
    if not omit_io_grpc_grpc_okhttp:
      io_grpc_grpc_okhttp()
    if not omit_io_grpc_grpc_protobuf:
      io_grpc_grpc_protobuf()
    if not omit_io_grpc_grpc_protobuf_lite:
      io_grpc_grpc_protobuf_lite()
    if not omit_io_grpc_grpc_protobuf_nano:
      io_grpc_grpc_protobuf_nano()
    if not omit_io_grpc_grpc_stub:
      io_grpc_grpc_stub()

    if not omit_io_netty_netty_buffer:
      io_netty_netty_buffer()
    if not omit_io_netty_netty_codec:
      io_netty_netty_codec()
    if not omit_io_netty_netty_codec_http:
      io_netty_netty_codec_http()
    if not omit_io_netty_netty_codec_http2:
      io_netty_netty_codec_http2()
    if not omit_io_netty_netty_common:
      io_netty_netty_common()
    if not omit_io_netty_netty_handler:
      io_netty_netty_handler()
    if not omit_io_netty_netty_resolver:
      io_netty_netty_resolver()
    if not omit_io_netty_netty_transport:
      io_netty_netty_transport()

# MAINTAINERS
#
# 1. Please sort everything in this file.
#
# 2. Every external rule must have a SHA checksum.
#
# 3. Use http:// URLs since we're relying on the checksum for security.
#
# fyi: An *.exe suffix does not imply a Windows executable when
# downloaded from maven repos.
#
# To update http_file(s) from maven servers, point your browser to
# https://repo1.maven.org/maven2, find the file, copy it down to your
# workstation (with curl perhaps), and compute the sha256:
#
# $ curl -O -J -L https://repo1.maven.org/maven2/com/google/protobuf/protoc/3.0.0/protoc-3.0.0-linux-x86_64.exe
# $ sha256sum protoc-3.0.0-linux-x86_64.exe #linux
# $ shasum -a256 protoc-3.0.0-osx-x86_64.exe # macosx

# def protobuf_java():
#   native.maven_jar(
#       name = "com_google_protobuf_protobuf_java",
#       artifact = "com.google.protobuf:protobuf-java:jar:3.0.0",
#       sha1 = "6d325aa7c921661d84577c0a93d82da4df9fa4c8",
#   )

def com_google_auth_google_auth_library_credentials():
  native.maven_jar(
      name = "com_google_auth_google_auth_library_credentials",
      artifact = "com.google.auth:google-auth-library-credentials:jar:0.4.0",
      sha1 = "171da91494a1391aef13b88bd7302b29edb8d3b3",
  )

def com_google_code_gson_gson():
  native.maven_jar(
      name = "com_google_code_gson_gson",
      artifact = "com.google.code.gson:gson:jar:2.3",
      sha1 = "5fc52c41ef0239d1093a1eb7c3697036183677ce",
  )

def com_google_code_findbugs_jsr305():
  native.maven_jar(
      name = "com_google_code_findbugs_jsr305",
      artifact = "com.google.code.findbugs:jsr305:jar:3.0.0",
      sha1 = "5871fb60dc68d67da54a663c3fd636a10a532948",
  )

def com_google_guava_guava():
  native.maven_jar(
      name = "com_google_guava_guava",
      artifact = "com.google.guava:guava:jar:19.0",
      sha1 = "6ce200f6b23222af3d8abb6b6459e6c44f4bb0e9",
  )

def com_google_protobuf_protobuf_java():
  native.maven_jar(
      name = "com_google_protobuf_protobuf_java",
      artifact = "com.google.protobuf:protobuf-java:jar:3.0.0",
      sha1 = "6d325aa7c921661d84577c0a93d82da4df9fa4c8",
  )

def com_google_protobuf_nano_protobuf_javanano():
  native.maven_jar(
      name = "com_google_protobuf_nano_protobuf_javanano",
      artifact = "com.google.protobuf.nano:protobuf-javanano:jar:3.0.0-alpha-5",
      sha1 = "357e60f95cebb87c72151e49ba1f570d899734f8",
  )

def com_google_protobuf_protobuf_java_util():
  native.maven_jar(
      name = "com_google_protobuf_protobuf_java_util",
      artifact = "com.google.protobuf:protobuf-java-util:jar:3.0.0",
      sha1 = "5c39485775c197fc1938e594dc358bfec1c188a0",
  )

def com_squareup_okhttp_okhttp():
  native.maven_jar(
      name = "com_squareup_okhttp_okhttp",
      artifact = "com.squareup.okhttp:okhttp:jar:2.5.0",
      sha1 = "4de2b4ed3445c37ec1720a7d214712e845a24636",
  )

def com_squareup_okio_okio():
  native.maven_jar(
      name = "com_squareup_okio_okio",
      artifact = "com.squareup.okio:okio:jar:1.6.0",
      sha1 = "98476622f10715998eacf9240d6b479f12c66143",
  )

def io_grpc_grpc_auth():
  native.maven_jar(
      name = "io_grpc_grpc_auth",
      artifact = "io.grpc:grpc-auth:jar:1.0.0-pre1",
      sha1 = "f0f297a406c45ecc030e2aca69b81a7ed67c3de7",
  )

def io_grpc_grpc_core():
  native.maven_jar(
      name = "io_grpc_grpc_core",
      artifact = "io.grpc:grpc-core:jar:1.0.0-pre1",
      sha1 = "6489670c182cb214cdcbbd7e6508b4f3ac831ce5",
  )

def io_grpc_grpc_netty():
  native.maven_jar(
      name = "io_grpc_grpc_netty",
      artifact = "io.grpc:grpc-netty:jar:1.0.0-pre1",
      sha1 = "53094773926bf863daa8faa3ff1175f3f6909ca8",
  )

def io_grpc_grpc_okhttp():
  native.maven_jar(
      name = "io_grpc_grpc_okhttp",
      artifact = "io.grpc:grpc-okhttp:jar:1.0.0-pre1",
      sha1 = "3cd4e41931268eef7c1ce00a2baecba6e53cb1da",
  )

def io_grpc_grpc_protobuf():
  native.maven_jar(
      name = "io_grpc_grpc_protobuf",
      artifact = "io.grpc:grpc-protobuf:jar:1.0.0-pre1",
      sha1 = "9e5235fbae40a22fe97a4cd55333b18969ef76cb",
  )

def io_grpc_grpc_protobuf_lite():
  native.maven_jar(
      name = "io_grpc_grpc_protobuf_lite",
      artifact = "io.grpc:grpc-protobuf-lite:jar:1.0.0-pre1",
      sha1 = "8ab07e256e0d9fb3650954f38bc09b5ea258b716",
  )

def io_grpc_grpc_protobuf_nano():
  native.maven_jar(
      name = "io_grpc_grpc_protobuf_nano",
      artifact = "io.grpc:grpc-protobuf-nano:jar:1.0.0-pre1",
      sha1 = "c88ce3b66d21eadcdfecb8326ecd976b2aecbe9f",
  )

def io_grpc_grpc_stub():
  native.maven_jar(
      name = "io_grpc_grpc_stub",
      artifact = "io.grpc:grpc-stub:jar:1.0.0-pre1",
      sha1 = "1fb325fdb52b0e5df3aea3a98b0f75119b2a3701",
  )

def io_netty_netty_buffer():
  native.maven_jar(
      name = "io_netty_netty_buffer",
      artifact = "io.netty:netty-buffer:jar:4.1.3.Final",
      sha1 = "e507ffb52a1d134679ed244ff819a99e96782dc4",
  )

def io_netty_netty_codec():
  native.maven_jar(
      name = "io_netty_netty_codec",
      artifact = "io.netty:netty-codec:jar:4.1.3.Final",
      sha1 = "790174576b97ab75a4edafd320f9a964a5473cdb",
  )

def io_netty_netty_codec_http():
  native.maven_jar(
      name = "io_netty_netty_codec_http",
      artifact = "io.netty:netty-codec-http:jar:4.1.3.Final",
      sha1 = "62fdf3c43f2674a61ad761b3d164b34dbe76e6cc",
  )

def io_netty_netty_codec_http2():
  native.maven_jar(
      name = "io_netty_netty_codec_http2",
      artifact = "io.netty:netty-codec-http2:jar:4.1.3.Final",
      sha1 = "4e68c878d8ae6988eb3425d4fc2c8d3eea69ff39",
  )

def io_netty_netty_common():
  native.maven_jar(
      name = "io_netty_netty_common",
      artifact = "io.netty:netty-common:jar:4.1.3.Final",
      sha1 = "620faa6dd83a08eb607c9d5c077a9b4edde3056b",
  )

def io_netty_netty_handler():
  native.maven_jar(
      name = "io_netty_netty_handler",
      artifact = "io.netty:netty-handler:jar:4.1.3.Final",
      sha1 = "0fff45bdc544a4eeceb5b4c6e3e571627af9fdb6",
  )

def io_netty_netty_resolver():
  native.maven_jar(
      name = "io_netty_netty_resolver",
      artifact = "io.netty:netty-resolver:jar:4.1.3.Final",
      sha1 = "fe4ba2ed19e4e8667068e917665f5725ee0290ea",
  )

def io_netty_netty_transport():
  native.maven_jar(
      name = "io_netty_netty_transport",
      artifact = "io.netty:netty-transport:jar:4.1.3.Final",
      sha1 = "2f17fe8c5c3b3f90908ed2d0649631a11beb3904",
  )

def protoc_gen_grpc_java_linux_x86_64():
  native.http_file(
      name = "protoc_gen_grpc_java_linux_x86_64",
      url = "http://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.0.0-pre1/protoc-gen-grpc-java-1.0.0-pre1-linux-x86_64.exe",
      sha256 = "4245b79757ce78a64dbec6f7facf64e1ff74fee411ce5b090c1114e1b5ec46d7",
  )

def protoc_gen_grpc_java_macosx():
  native.http_file(
      name = "protoc_gen_grpc_java_macosx",
      url = "http://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.0.0-pre1/protoc-gen-grpc-java-1.0.0-pre1-osx-x86_64.exe",
      sha256 = "850fd0420cb896dfcd1f7d1edd6b3cb010890f8732f84821af5ef6b5f89e885d",
      executable = True,
  )

# def protobuf_java():
#   native.maven_jar(
#       name = "com_google_protobuf_protobuf_java",
#       artifact = "com.google.protobuf:protobuf-java:jar:3.0.0",
#       sha1 = "6d325aa7c921661d84577c0a93d82da4df9fa4c8",
#   )

# def protoc_linux_x86_64():
#   native.http_file(
#       name = "protoc_linux_x86_64",
#       url = "http://repo1.maven.org/maven2/com/google/protobuf/protoc/3.0.0/protoc-3.0.0-linux-x86_64.exe",
#       sha256 = "98e235228b70e747ac850f1411d1d5de351c2dc3227a4086b1d940b5e099257f",
#   )

# def protoc_macosx():
#   native.http_file(
#       name = "protoc_macosx",
#       url = "http://repo1.maven.org/maven2/com/google/protobuf/protoc/3.0.0/protoc-3.0.0-osx-x86_64.exe",
#       sha256 = "d9a1dd45e3eee4a9abfbb4be26172d69bf82018a3ff5b1dff790c58edbfcaf4a",
#   )
