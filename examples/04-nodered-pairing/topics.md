# 04-nodered-pairing — topic convention for the Node-RED side

The broker side of the pairing is a topic convention; the flow itself lives
in nodered-cookbook. This pattern proves the broker side only.

## Convention

```
sensors/<station>/reading   — one JSON reading per message (see 01-pub-sub)
sensors/<station>/status    — retained last-will / status (retained, QoS 1)
```

- `<station>` is a synthetic station id (S1, S2, S3 in examples). Never a
  real device id or location.
- Readings are QoS 1, not retained: a late subscriber gets new readings,
  not a stale one. Status messages ARE retained so a new subscriber learns
  the last known status immediately.

## Node-RED sketch

`flow.json` is a sketch, not a verified flow: an `mqtt in` node subscribed
to `sensors/#`, a function node that parses the JSON, and a debug node.
Import it into a Node-RED instance, point its MQTT broker config at the
test broker (localhost:1883), and feed it with `feed.sh`. The verified
Node-RED flow pass belongs to nodered-cookbook.
