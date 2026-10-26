# 03-auth-note — authentication options and the open fleet decision

**Evidence:** design-only, gate 1 target. Not runtime-validated on the fleet.
**Versions:** Mosquitto 2.1.2 (fleet record).

## The open fleet decision (stated, not settled)

Broker authentication is an open fleet decision, and this pattern does not
present any option as settled policy:

- **Node-1** runs `allow_anonymous true` on port 18883. That setting was
  agent-set during the wave-5 install, and its alignment with Node-3 is
  pending Alex's decision.
- **Node-3** is localhost-only on 1883, and anonymous connections were
  refused there — so in practice auth is required on that host.

The test broker in this pattern uses `allow_anonymous false` with a password
file and an ACL, because that is the restrictive option and the one a new
deployment should start from. Which option the fleet adopts is Alex's call,
not this cookbook's.

## Run

```bash
bash test-auth.sh
```

## Expected output

- Authenticated publish (demo-publisher): OK.
- Anonymous publish: refused (expected).

The credential in the script is a placeholder (`CHANGE-ME-do-not-use`),
generated into a throwaway `passwords.txt` that the script deletes on exit.
No fleet credential appears anywhere in this pattern.

## Failure behavior

- Wrong password: "Connection Refused: not authorised".
- Missing password file: broker startup fails naming the file.
- A publish to a non-`sensors/` topic as demo-publisher: denied by the ACL.

## To confirm at validation

- The fleet auth decision itself (Alex's call) and, once made, a fleet
  migration note — deliberately NOT written here in advance.
- `mosquitto_passwd -b` batch-mode behavior on 2.1.2.
