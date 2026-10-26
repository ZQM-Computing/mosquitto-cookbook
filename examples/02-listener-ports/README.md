# 02-listener-ports — listener configuration, including excluded-port workarounds

**Evidence:** design-only, gate 1 target. Not runtime-validated on the fleet.
**Versions:** Mosquitto 2.1.2 (fleet record).

## What it demonstrates

Three listener variants and the fleet facts behind them:

- **Localhost-only `:1883`** — the safe default for examples.
- **Shifted `:18883`** — for hosts where 1883 is unusable. On Node-1, 1883
  sits in the Windows excluded range 1827–1926, so the fleet broker there
  listens on 18883.
- **Tailnet-scoped bind** — bind to the node's tailnet IP. A `0.0.0.0` bind
  is never shown: the fleet's private-binding rule forbids it here.

## Run

```bash
bash check.sh
```

## Expected output

A non-empty `$SYS/broker/version` payload (exact string varies by build and
is a validation item; the check asserts non-empty, not a literal version).

## Failure behavior

- Port in use: broker startup fails ("Address already in use").
- Wrong port: subscriber fails with "Connection refused".
- Anonymous refused: subscriber fails with "Connection Refused: not
  authorised" — that means the broker needs the `03-auth-note` config, not
  this test config. This is exactly what Node-3's localhost-only setup does.

## To confirm at validation

- The exact `$SYS/broker/version` payload string on 2.1.2.
- That the excluded-range fact (1827–1926) still holds on Node-1 before
  reusing the shifted port anywhere.
