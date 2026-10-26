#!/bin/bash
# 03-auth-note: prove authenticated publish works and anonymous publish fails.
# PLACEHOLDER credential only (demo-publisher / CHANGE-ME-do-not-use).
# Expected: the authenticated publish succeeds; the anonymous publish is refused.
set -e
cd "$(dirname "$0")"
mosquitto_passwd -b -c passwords.txt demo-publisher 'CHANGE-ME-do-not-use'
mosquitto -c auth.conf &
BROKER_PID=$!
trap 'kill $BROKER_PID 2>/dev/null || true; rm -f passwords.txt' EXIT
sleep 2
mosquitto_pub -h 127.0.0.1 -p 1883 -u demo-publisher -P 'CHANGE-ME-do-not-use' \
  -t 'sensors/S1/reading' -m '{"station":"S1","temp_c":21.5}' -q 1
echo "authenticated publish: OK"
if mosquitto_pub -h 127.0.0.1 -p 1883 -t 'sensors/S1/reading' \
    -m '{"station":"S1","temp_c":21.5}' -q 1 2>/dev/null; then
  echo "ERROR: anonymous publish unexpectedly succeeded" >&2
  exit 1
fi
echo "anonymous publish: refused (expected)"
# Failure behavior:
# - Wrong password: authenticated publish fails with "Connection Refused:
#   not authorised".
# - Missing password_file: broker startup fails naming the file.
