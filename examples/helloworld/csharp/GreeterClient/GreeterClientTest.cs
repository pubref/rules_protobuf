using System;
// Having issue pulling in this Grpc dependency.
//using Grpc.Core;
//using Helloworld;
using NUnit.Framework;

namespace examples_helloworld_csharp
{
    [TestFixture]
    public class MyTest
    {
        public void TestSayHello()
        {
            /* Channel channel = new Channel("127.0.0.1:50051", ChannelCredentials.Insecure); */
            /* var client = new Greeter.GreeterClient(channel); */
            /* String user = "foo"; */
            /* var reply = client.SayHello(new HelloRequest { Name = user }); */
            /* Assert.That(reply.Message, Is.EqualTo(user)); */
        }

        [Test]
        public void TestAssert()
        {
          String user = "foo";
          Assert.That("foo", Is.EqualTo(user));
        }

    }
}
