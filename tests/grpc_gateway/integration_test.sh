# rules_go creates output binary in a os_arch dependent location...
SERVER=`find go | grep server`
GATEWAY=`find go | grep gateway`
CLIENT=`find go | grep client`

echo "Starting server: $SERVER"
"$SERVER" &

echo "Starting gateway: $GATEWAY"
"$GATEWAY" &

sleep 1

echo "Sending post..."
"$CLIENT"

