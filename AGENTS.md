<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# f5m/i2p-reseed

Docker image built on [b19/go](../../b19/go/AGENTS.md) and [b19/ubuntu](../../b19/ubuntu/AGENTS.md)

I2P reseed server ([go-i2p/reseed-tools](https://github.com/go-i2p/reseed-tools)) — serves signed SU3 seed bundles to routers joining the network. Sibling of [f5m/i2p](../i2p/AGENTS.md) (the router).

## Key facts

- Builder: `b19/go` → Final Base: `b19/ubuntu/resolute`
- Arch: amd64 only
- Pinned version: `.container/compile-go/deps/reseed-tools/version.deps` (hash-verified via `b19-fetch`)
- `CGO_ENABLED=0` static build

## Keys (bootstrap.d)

`100-generate-keys.sh` generates the SU3 signing key on FIRST boot only (`reseed-tools keygen`, RSA-4096, takes ~1 min), under a `flock` lock so two containers sharing the volume cannot race. Existing keys are never overwritten. All key material (`<signer>_at_<host>.pem/.crt/.rl`) lands in `F5M_I2P_RESEED_KEYS_DIR`; publish the `.crt` when registering the reseed server with zzz. The entrypoint passes `--key` explicitly, so CWD is irrelevant. `F5M_I2P_RESEED_SIGNER` empty → startup aborts with a clear log (upstream refuses empty/placeholder signers anyway).

## Ports

- `8080` — reseed HTTP (plain behind Traefik via `--trustProxy`; upstream default is 8443, we follow the fleet convention)

Routes: `/` web homepage (rate-limited 40/h per IP), `/i2pseeds.su3` seed bundles (rate-limited 4/h per IP; requires the I2P router User-Agent `Wget/1.11.4` — anything else gets 403).

## netDb source

The server signs whatever it finds in `F5M_I2P_RESEED_NETDB` (default `${B19_HOME}/.i2p/netDb` — exactly where a co-running router writes). The dev compose runs a sibling `f5m/i2p` router and mounts ONE named volume (`i2p-shared-config`) at `/app/.i2p` in BOTH containers — that dir is the router’s default config dir, so no path translation. Alternatively mount any populated netDb at the same path, or let upstream pull one (`F5M_I2P_RESEED_ARGS="--share-peer=…"`; needs SAM). An empty netDb starts fine but serves nothing.

## Upstream startup probe quirk

Every `reseed-tools` subcommand probes `$HOME/.i2p` at startup (`getmeanetdb.WhereIstheNetDB`) and Fatals when absent — even `version`. `volumes.deps` therefore pre-creates `${B19_HOME}/.i2p` at build time; it doubles as the shared-volume mountpoint above.

## Volumes

- `i2p-shared-config` → `/app/.i2p` (shared with sibling router: its config + the served netDb)
- `i2p-reseed-data` → `/app/data` (= `${XDG_DATA_HOME}`) — persists the SU3 signing key (`keys/`)

## Healthcheck nuance

The homepage is rate-limited per IP; the container’s own healthcheck exhausts its localhost budget (~40/h at 30 s cadence). `100-check-reseed-health.sh` therefore treats HTTP 429 as healthy — only a non-answer or 5xx fails.

## Not included

No docker-in-image, no systemd, no cron (the guide’s systemd/crontab steps are replaced by bootstrap.d + entrypoint.d + container restart policy). No onion/I2P listeners by default — enable via `F5M_I2P_RESEED_ARGS` (`--onion`, `--i2p`) if a Tor/SAM endpoint is reachable.

## Documentation

[Project goals and objectives](@docs/goal.md)
[Fitness criteria and acceptance](@docs/fit.md)
[Completed features and milestones](@docs/done.md)
[Known limitations and caveats](@docs/caveats.md)
[Future development plans](@docs/roadmap.md)
[Available make targets](@docs/MAKEFILE.md)
