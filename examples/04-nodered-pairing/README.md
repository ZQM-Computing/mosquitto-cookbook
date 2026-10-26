# 04-nodered-pairing — pairing with Node-RED flows

**Evidence:** design-only, gate 1 target. Not runtime-validated on the fleet.
**Versions:** Mosquitto 2.1.2 (fleet record); Node-RED flow sketch only.

## What it demonstrates

The broker side of a Mosquitto + Node-RED pairing: a topic convention
(`sensors/<station>/reading`, `sensors/<station>/status`), a retained
status topic, and a feed script that publishes convention-shaped messages.

## Run

```bash
# Terminal 1: start the local test broker from 01-pub-sub
mosquitto -c ../01-pub-sub/broker.conf
# Terminal 2: publish the feed
bash feed.sh
```

## Expected output

- Both publishes exit 0.
- A flow subscribed to `sensors/#` sees one reading and one retained status.

## Failure behavior

- Broker down: publishes fail with "Connection refused".
- Status published without `-r`: a late subscriber misses the last status.

## To confirm at validation

- The flow itself: `flow.json` is a sketch. The verified Node-RED flow pass
  belongs to nodered-cookbook, not here — this pattern deliberately does
  not claim a working flow.
- That the topic convention matches whatever nodered-cookbook's flow
  expects (single source of truth should be the flow, once verified).
