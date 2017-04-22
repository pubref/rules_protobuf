#include "gtest/gtest.h"

//#include "tests/proto_file_in_subdirectory/foo/bar/baz.pb.h"
//#include "google_well_known_protos/examples/wkt/cpp/src/google/protobuf/empty.pb.h"
#include "google/protobuf/empty.pb.h"

TEST(WktTest, CanCreateMessage) {
  GOOGLE_PROTOBUF_VERIFY_VERSION;
  //foo::bar::baz::Qux msg = foo::bar::baz::Qux();
  google::protobuf::Empty msg = google::protobuf::Empty();
  //msg.set_verbose(1);
  EXPECT_EQ(1, 1);
}

int main(int ac, char* av[]) {
  testing::InitGoogleTest(&ac, av);
  return RUN_ALL_TESTS();
}
