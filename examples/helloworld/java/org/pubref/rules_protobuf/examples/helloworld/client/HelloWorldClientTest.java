package org.pubref.rules_protobuf.examples.helloworld.client;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNotNull;

import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;


/**
 * A simple test that primarily checks that the client can compile.
 */
public class HelloWorldClientTest {

  HelloWorldClient client;

  @Before
  public void setUp() throws Exception {
    client = new HelloWorldClient("localhost", 50051);
  }

  @After
  public void tearDown() throws InterruptedException {
    client.shutdown();
  }

  @Test
  public void testGreet() throws InterruptedException {
    client.greet("world");
  }

}
