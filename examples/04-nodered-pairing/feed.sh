#!/bin/bash
# 04-nodered-pairing feed: publish convention-shaped messages for a
# Node-RED flow (flow.json sketch) to consume. Run against the LOCAL test
# broker from 01-pub-sub (broker.conf), started separately.
# Expected: both publishes exit 0; a flow subscribed to sensors/# sees
# one reading and one retained status.
set -e
mosquitto_pub -h 127.0.0.1 -p 1883 -t 'sensors/S1/reading' \
  -m '{"station":"S1","temp_c":21.5,"rh":55}' -q 1
mosquitto_pub -h 127.0.0.1 -p 1883 -t 'sensors/S1/status' \
  -m '{"station":"S1","status":"online"}' -q 1 -r
echo "feed published: reading + retained status"
# Failure behavior:
# - Broker down: both publishes fail with "Connection refused".
# - Retained status without -r: a late subscriber misses the last status;
#   the -r flag is the whole point of the status topic.
