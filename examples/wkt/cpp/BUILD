package(default_visibility = ["//visibility:public"])

load("//cpp:rules.bzl", "cc_proto_library")

cc_proto_library(
    name = "google_well_known_protos",
    includes = [
        "empty.proto",
    ],
    protos = ["@com_google_protobuf//:well_known_protos"],
    verbose = 0,
    with_grpc = False,
)

# NOT WORKING YET
#
# cc_test(
#     name = "wkt_test",
#     size = "small",
#     srcs = ["wkt_test.cc"],
#     copts = [
#         "-Iexternal/gtest/include",
#         "-Iexternal/com_google_protobuf/google/protobuf",
#     ],
#     deps = [
#         ":google_well_known_protos",
#         #"@com_google_protobuf//:protobuf",
#         #"@com_google_protobuf//:cc_wkt_protos",
#         "@gtest//:gtest",
#     ],
# )
