set -euo pipefail

server&

if client 'gogo' 2>&1 | grep 'API Response: Hello gogo'; then
    echo "PASS"
else
    exit 1
fi
