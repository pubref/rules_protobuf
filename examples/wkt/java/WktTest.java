package examples.wkt.java;

import com.google.protobuf.Struct;
import com.google.protobuf.Value;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;

public class WktTest {

  @Test
  public void testWkt() {
    Struct struct = Struct.newBuilder()
      .putFields("label", Value.newBuilder().setStringValue("foo").build())
      .putFields("weight", Value.newBuilder().setNumberValue(0.85).build())
      .build();
    assertEquals("Well-known struct class should return correct label", "foo", struct.getFields().get("label").getStringValue());
    assertEquals("Well-known struct class should return correct weight", 0.85, struct.getFields().get("weight").getNumberValue(), 0.00001);
  }

}
