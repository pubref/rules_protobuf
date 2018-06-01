#!/bin/bash 
# A simple test for the rust client-server.
set -eu
set -o pipefail

# Try to locate the runfiles directory
get_runfiles_dir() {
    if [ -d "${BASH_SOURCE[0]}.runfiles" ]; then
        cd "${BASH_SOURCE[0]}.runfiles/org_pubref_rules_protobuf"
    elif ! [ -d "${PWD}/../org_pubref_rules_protobuf" ]; then
        cd "$(readlink ${BASH_SOURCE[0]}).runfiles/org_pubref_rules_protobuf"
    fi
    pwd -P
}

RUNFILES="${RUNFILES:-"$(get_runfiles_dir)"}"
TEST_TMPDIR="${TEST_TMPDIR:-$(mktemp -d ${TMP:-/tmp}/tmp.XXXXXXXX)}"
SERVER="${RUNFILES}/examples/helloworld/rust/greeter_server/greeter_server"
CLIENT="${RUNFILES}/examples/helloworld/rust/greeter_client/greeter_client"

SERVER_LOG="${TEST_TMPDIR}/server.log"
CLIENT_LOG="${TEST_TMPDIR}/client.log"

# Simply match a string from the log
expect_log() {
    local log="${2-${CLIENT_LOG}}"
    if ! grep -qF "$1" "${log}"; then
        echo "Substring '$1' not found in ${log}." >&2
        echo "=== ${log} ===" >&2
        cat "${log}" >&2
        echo "=== end of ${log} ===" >&2
    fi
}

# Start the server and get its pid and its port number
"${SERVER}" 0 | tee "${SERVER_LOG}" &
server_pid=$?
trap "kill ${server_pid}" EXIT

while ! grep -q "greeter server started on port" "${SERVER_LOG}" &>/dev/null; do
    sleep 1
done

PORT=$(grep "greeter server started on port" "${SERVER_LOG}" \
      | sed -E 's/^.*port //')

# Now run the client
"${CLIENT}" -p="${PORT}" | tee "${CLIENT_LOG}"
expect_log 'message: "Hello world"'
expect_log 'greeting request from world' "${SERVER_LOG}"

"${CLIENT}" -p="${PORT}" thou | tee "${CLIENT_LOG}"
expect_log 'message: "Hello thou"'
expect_log 'greeting request from thou' "${SERVER_LOG}"

echo ""
echo "SUCCESS"