# Mosquitto Cookbook

<!-- ZQM-START -->
<!-- markdownlint-disable MD033 -->
<p align="center">
  <strong>ZQM Computing — Geospatial Engineering & Scientific Computing</strong><br>
  <a href="https://github.com/ZQM-Computing">ZQM Computing</a>
</p>
<!-- markdownlint-enable MD033 -->
<!-- ZQM-END -->

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

A **Mosquitto cookbook** for MQTT broker setup, listeners, and pub/sub patterns. Patterns are drawn from the ZQM fleet's Mosquitto 2.1.2 installs. Honest caveat: broker authentication is an open fleet decision — Node-1 runs allow-anonymous on port 18883 (1883 sits in an excluded range) while Node-3 is localhost-only. This cookbook does not present allow-anonymous as settled policy; the auth pass lands when the decision does. It is intended for Engineers who move sensor and service messages over MQTT. Validate each pattern against your own data, software versions, and operating environment before adopting it.

## Repository role and status

**Status:** Active, public — seeding. Pattern passes land in follow-up work from fleet-verified setups; the tables below list what is planned, not what is already written.

**What this repository is:** Mosquitto patterns — see the table below.

**What it contributes:** Part of the ZQM Computing geospatial portfolio. The umbrella index for the series is [geospatial-cookbooks](https://github.com/ZQM-Computing/geospatial-cookbooks).

**Standing:** This repository is maintained independently. Automated checks cover only the paths and environments configured in its workflows; they do not establish production readiness or operational certification.

## Who this is for

Engineers who move sensor and service messages over MQTT.

## Prerequisites

- Mosquitto 2.1.2
- An MQTT client for the pub/sub passes
- Bash or PowerShell

## Patterns (planned)

| # | Example | What it will demonstrate |
|---|---------|--------------------------|
| 01 | `01-pub-sub` | Publishing and subscribing across topics |
| 02 | `02-listener-ports` | Listener configuration, including excluded-port workarounds |
| 03 | `03-auth-note` | Authentication options and the open fleet decision |
| 04 | `04-nodered-pairing` | Pairing with Node-RED flows (see nodered-cookbook) |

## Repository layout

```text
mosquitto-cookbook/
├── examples/          # pattern passes, landing in follow-up work
├── README.md
└── LICENSE
```

## Roadmap

- First pattern pass: the first two table rows
- Second pass: the remaining rows, from fleet-verified setups

## Contributing

A contributing guide lands with the first pattern pass. Report security issues to <zqmcomputing@gmail.com> — please do not open a public issue for those.

## More from this series

- [nodered-cookbook](https://github.com/ZQM-Computing/nodered-cookbook) — Flow-based automation for geospatial and IoT triggers
- [grafana-cookbook](https://github.com/ZQM-Computing/grafana-cookbook) — Dashboards, datasources, and alerts for geospatial stacks
- [prometheus-cookbook](https://github.com/ZQM-Computing/prometheus-cookbook) — Metrics, scrape jobs, PromQL, and alert rules
