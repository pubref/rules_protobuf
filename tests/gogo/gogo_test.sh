#!/bin/bash

set -euo pipefail

if [ -f linux_amd64_stripped/server ]; then
    linux_amd64_stripped/server&

    if linux_amd64_stripped/client 'gogo' 2>&1 | grep 'API Response: Hello gogo'; then
        echo "PASS"
        exit 0
    else
        exit 1
    fi
else
    darwin_amd64_stripped/server&

    if darwin_amd64_stripped/client 'gogo' 2>&1 | grep 'API Response: Hello gogo'; then
        echo "PASS"
        exit 0
    else
        exit 1
    fi
fi

# neither file exists
exit 1
