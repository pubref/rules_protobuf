/**
 * @fileoverview Test the greeter implementation.
 */
goog.setTestOnly();

goog.require('examples.helloworld.closure.Greeter');
goog.require('goog.testing.asserts');
goog.require('goog.testing.jsunit');
goog.require('proto.helloworld.HelloRequest');


function testSayHello() {
  //var active = goog.testing.TestCase.getActiveTest();

  var greeter = new examples.helloworld.closure.Greeter();
  var request = new proto.helloworld.HelloRequest();
  var name = "foo";
  request.setName(name);

  var reply = greeter.sayHello(request);
  greeter.dispose();

  assertEquals("Hello, " + name, reply.getMessage());
}
