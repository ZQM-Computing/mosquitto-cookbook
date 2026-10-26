# 01-pub-sub — publishing and subscribing across topics

**Evidence:** design-only, gate 1 target. Not runtime-validated on the fleet.
**Versions:** Mosquitto 2.1.2 (fleet record, Node-1 and Node-3).

## What it demonstrates

A local test broker (localhost-only, from `broker.conf`) and a three-message
round trip: three synthetic sensor readings published to
`sensors/<station>/reading` and received by one wildcard subscriber
(`sensors/#`) with QoS 1.

## Run

```bash
bash roundtrip.sh
```

## Expected output

Exactly the three published JSON payloads, in publish order (S1, S2, S3),
followed by a passing 3-line count check.

## Failure behavior

- Broker down or port busy: startup fails ("Address already in use") or
  clients fail with "Connection refused".
- Wrong topic filter: fewer than 3 lines arrive and the count test fails.

## To confirm at validation

- That `mosquitto_sub -C 3` exits after exactly 3 messages on 2.1.2.
- Payloads are synthetic station readings only — no real sensor locations,
  no real-place data.
- The `allow_anonymous true` in `broker.conf` is TEST-ONLY. It is not fleet
  policy; see `03-auth-note` for the open fleet decision.
