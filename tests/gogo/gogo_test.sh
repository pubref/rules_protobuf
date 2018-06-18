set -euo pipefail

linux_amd64_stripped/server&

if linux_amd64_stripped/client 'gogo' 2>&1 | grep 'API Response: Hello gogo'; then
    echo "PASS"
else
    exit 1
fi
