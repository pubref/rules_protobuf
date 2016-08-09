package org.pubref.rules_protobuf.examples.helloworld.server;

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
 * A simple test that primarily checks that the server can compile.
 */
public class HelloWorldServerTest {

  HelloWorldServer server;

  @Before
  public void setUp() throws Exception {
    server = new HelloWorldServer();
    server.start();
  }

  @After
  public void tearDown() throws InterruptedException {
  }

  @Test
  public void testNothing() throws InterruptedException {
  }

}
