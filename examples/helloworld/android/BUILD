package(default_visibility = ["//visibility:public"])

android_library(
    name = "android",
    srcs = [
        "MainActivity.java",
        "//examples/proto:android.pb",
        "//examples/helloworld/proto:android.pb",
    ],
    resource_files = glob(["res/**/*"]),
    deps = [
        #"//examples/helloworld/proto:android",
        "//android:grpc_compiletime_deps",
    ],
    custom_package = "examples.helloworld.android",
    manifest = "AndroidManifest.xml",
)

android_binary(
    name = "main",
    deps = [
        ":android",
        "//android:netty_runtime_deps",
    ],
    multidex = "native",
    dex_shards = 4,
    custom_package = "examples.helloworld.android",
    manifest = "AndroidManifest.xml",
)
