#!/bin/bash
# 02-listener-ports: prove the test listener answers and reports a version.
# Expected: a non-empty $SYS/broker/version payload (exact string varies
# by build and is a validation item; the check asserts non-empty, not a
# literal version).
set -e
cd "$(dirname "$0")"
mosquitto -c listeners.conf &
BROKER_PID=$!
trap 'kill $BROKER_PID 2>/dev/null || true' EXIT
sleep 2
VERSION=$(mosquitto_sub -h 127.0.0.1 -p 1883 -t '$SYS/broker/version' -C 1)
echo "broker version: $VERSION"
test -n "$VERSION"
# Failure behavior:
# - Port already in use: mosquitto exits at startup ("Address already in use").
# - Wrong port: mosquitto_sub fails with "Connection refused".
# - Anonymous refused (as on Node-3's localhost-only setup): mosquitto_sub
#   fails with "Connection Refused: not authorised" — that means the broker
#   needs the 03-auth-note config, not this test config.
