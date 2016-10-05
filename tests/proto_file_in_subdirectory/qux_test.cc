#include "gtest/gtest.h"

#include "tests/proto_file_in_subdirectory/foo/bar/baz.pb.h"

TEST(QuxTest, CanCreateMessage) {
  GOOGLE_PROTOBUF_VERIFY_VERSION;
  foo::bar::baz::Qux msg = foo::bar::baz::Qux();
  msg.set_verbose(1);
  EXPECT_EQ(1, msg.verbose());
}

int main(int ac, char* av[]) {
  testing::InitGoogleTest(&ac, av);
  return RUN_ALL_TESTS();
}
