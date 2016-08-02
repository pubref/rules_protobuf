def deps(
  omit_protoc_linux_x86_64=False,
  omit_protoc_macosx=False):

  if not omit_protoc_linux_x86_64:
    protoc_linux_x86_64()
  if not omit_protoc_macosx:
    protoc_macosx()


def protoc_linux_x86_64():
  native.http_file(
      name = "protoc_linux_x86_64",
      url = "http://repo1.maven.org/maven2/com/google/protobuf/protoc/3.0.0/protoc-3.0.0-linux-x86_64.exe",
      sha256 = "98e235228b70e747ac850f1411d1d5de351c2dc3227a4086b1d940b5e099257f",
  )


def protoc_macosx():
  native.http_file(
      name = "protoc_macosx",
      url = "http://repo1.maven.org/maven2/com/google/protobuf/protoc/3.0.0/protoc-3.0.0-osx-x86_64.exe",
      sha256 = "d9a1dd45e3eee4a9abfbb4be26172d69bf82018a3ff5b1dff790c58edbfcaf4a",
  )
