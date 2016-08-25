# Adapted from https://github.com/mzhaom/trunk/blob/master/third_party/gtest/BUILD
licenses(["notice"])

cc_library(
    name = "gtest",
    testonly = 1,
    visibility = ["//visibility:public"],
    includes = [
        "googletest/include",
    ],
    hdrs = [
        "googletest/include/gtest/gtest-death-test.h",
        "googletest/include/gtest/gtest-message.h",
        "googletest/include/gtest/gtest_pred_impl.h",
        "googletest/include/gtest/gtest-test-part.h",
        "googletest/include/gtest/gtest.h",
        "googletest/include/gtest/gtest-param-test.h",
        "googletest/include/gtest/gtest-printers.h",
        "googletest/include/gtest/gtest-spi.h",
        "googletest/include/gtest/gtest-typed-test.h"
    ],
    srcs = glob([
        "googletest/include/gtest/internal/**/*.h"
    ]) + [
        "googletest/src/gtest-internal-inl.h",
        "googletest/src/gtest-death-test.cc",
        "googletest/src/gtest-filepath.cc",
        "googletest/src/gtest-port.cc",
        "googletest/src/gtest-printers.cc",
        "googletest/src/gtest-test-part.cc",
        "googletest/src/gtest-typed-test.cc",
        "googletest/src/gtest.cc",
    ],
    copts = [
        "-Iexternal/gtest/googletest"
    ],
    deps = [
        ":gtest_prod",
    ],
)

cc_library(
    name = "gtest_main",
    testonly = 1,
    visibility = ["//visibility:public"],
    deps = [
        ":gtest",
    ],
    srcs = [
        "googletest/src/gtest_main.cc",
    ],
)

cc_library(
    name = "gtest_prod",
    visibility = ["//visibility:public"],
    hdrs = [
        "googletest/include/gtest/gtest_prod.h",
    ],
)

cc_library(
    name = "googlemock",
    testonly = 1,
    visibility = ["//visibility:public"],
    hdrs = [
        "googlemock/include/gmock/gmock-actions.h",
        "googlemock/include/gmock/gmock-cardinalities.h",
        "googlemock/include/gmock/gmock-generated-actions.h",
        "googlemock/include/gmock/gmock-generated-function-mockers.h",
        "googlemock/include/gmock/gmock-generated-matchers.h",
        "googlemock/include/gmock/gmock-generated-nice-strict.h",
        "googlemock/include/gmock/gmock.h",
        "googlemock/include/gmock/gmock-matchers.h",
        "googlemock/include/gmock/gmock-more-actions.h",
        "googlemock/include/gmock/gmock-more-matchers.h",
        "googlemock/include/gmock/gmock-spec-builders.h",
    ],
    srcs = glob([
        "googlemock/include/gmock/internal/**/*.h"
    ]) + [
        "googlemock/src/gmock-cardinalities.cc",
        "googlemock/src/gmock.cc",
        "googlemock/src/gmock-internal-utils.cc",
        "googlemock/src/gmock-matchers.cc",
        "googlemock/src/gmock-spec-builders.cc",
    ],
    deps = [
        ":gtest",
    ],
    includes = [
        "googlemock/include",
    ],
)

cc_library(
    name = "gmock_main",
    visibility = ["//visibility:public"],
    deps = [
        ":gmock",
    ],
    srcs = [
        "googlemock/src/gmock_main.cc",
    ],
)
