#!/bin/bash
# 01-pub-sub round trip against a LOCAL test broker started from broker.conf.
# Expected: the subscriber prints exactly the 3 published payloads, in order.
set -e
cd "$(dirname "$0")"
mosquitto -c broker.conf &
BROKER_PID=$!
trap 'kill $BROKER_PID 2>/dev/null || true' EXIT
sleep 2
mosquitto_sub -h 127.0.0.1 -p 1883 -t 'sensors/#' -C 3 > received.txt &
SUB_PID=$!
sleep 1
mosquitto_pub -h 127.0.0.1 -p 1883 -t 'sensors/S1/reading' -m '{"station":"S1","temp_c":21.5,"rh":55}' -q 1
mosquitto_pub -h 127.0.0.1 -p 1883 -t 'sensors/S2/reading' -m '{"station":"S2","temp_c":22.0,"rh":52}' -q 1
mosquitto_pub -h 127.0.0.1 -p 1883 -t 'sensors/S3/reading' -m '{"station":"S3","temp_c":20.8,"rh":58}' -q 1
wait $SUB_PID
cat received.txt
test "$(wc -l < received.txt)" -eq 3
# Failure behavior:
# - Broker down or port busy: mosquitto fails at startup ("Address already in
#   use") or clients fail with "Connection refused".
# - Wrong topic filter (e.g. sensors/S1 only): fewer than 3 lines arrive and
#   the final count test fails.
