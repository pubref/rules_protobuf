import unittest

import grpc
import greeter_server

from examples.helloworld.proto import helloworld_pb2
from examples.helloworld.proto import helloworld_pb2_grpc


def _get_random_port():
    import socket
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind(("", 0))
    s.listen(1)
    port = s.getsockname()[1]
    s.close()
    return port

TEST_PORT = _get_random_port()


class GreeterServerTest(unittest.TestCase):
    _server = None
    _client = None

    def setUp(self):
        self._server = greeter_server._GreeterServer(greeter_server._GreeterService(), TEST_PORT)
        self._server.start()
        channel = grpc.insecure_channel('localhost:{port}'.format(port=TEST_PORT))
        self._client = helloworld_pb2_grpc.GreeterStub(channel)

    def tearDown(self):
        self._server.stop()

    def test_sayhello(self):
        hello_reply = self._client.SayHello(helloworld_pb2.HelloRequest(name='you'))
        self.assertEqual(hello_reply.message, 'Hello you')

if __name__ == '__main__':
    unittest.main()
