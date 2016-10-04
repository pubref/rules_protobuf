/**
 * @fileoverview Create a helloworld message.
 */
goog.provide('examples.helloworld.closure.Greeter');

goog.require('goog.events.EventTarget');
goog.require('proto.helloworld.HelloReply');
goog.require('proto.helloworld.HelloRequest');


/**
 * Mock greeter implementation. As there is no current browser support
 * for gRPC, this is just a fake implementation whose primary use is
 * to demo the use of the message protos.
 *
 * @constructor
 * @extends {goog.events.EventTarget}
 */
examples.helloworld.closure.Greeter = function() {
  goog.events.EventTarget.call(this);
};
goog.inherits(examples.helloworld.closure.Greeter, goog.events.EventTarget);


/**
 * Greet!
 *
 * @param {!proto.helloworld.HelloRequest} request
 * @return {!proto.helloworld.HelloReply}
 */
examples.helloworld.closure.Greeter.prototype.sayHello = function(request) {
  var reply = new proto.helloworld.HelloReply();
  reply.setMessage("Hello, " + request.getName());
  return reply;
};
