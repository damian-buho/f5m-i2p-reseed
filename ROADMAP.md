<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
-->

[Español](docs/es/ROADMAP.md) · [Українська](docs/uk/ROADMAP.md)

# Roadmap

## Project Roadmap

### In-network reseed over I2P

- **Problem.** The server only reseeds over clearnet, so an operator who wants their reseed reachable from inside I2P — or a network where clearnet reachability is fragile — has no supported path; the raw `--i2p` flag exists but nothing models its SAM endpoint or keys.
- **Under consideration.** First-class `F5M_I2P_RESEED_I2P_ENABLED` wiring with a SAM address env, reusing the sibling `f5m/i2p` router as the SAM provider.
- **Rests on.** Upstream’s `--i2p` listener and `reseed.i2pkeys` handling; a running `f5m/i2p` with SAM enabled.

### Onion listener with f5m/tor

- **Problem.** Reseeding over an onion service would let censored routers bootstrap without touching clearnet at all, but the upstream `--onion` flag needs a Tor control port this image neither starts nor documents.
- **Under consideration.** An `F5M_I2P_RESEED_ONION_ENABLED` toggle that points upstream’s Tor client at a shared `f5m/tor` instance and persists the onion key next to the SU3 signing key.
- **Rests on.** Upstream’s `--onion`/`--singleOnion` listeners; the sibling `f5m/tor` image as the egress Tor.
