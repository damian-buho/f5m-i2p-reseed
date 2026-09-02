<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
-->

[Español](docs/es/ROADMAP.md) · [Українська](docs/uk/ROADMAP.md)

# Roadmap

## Project Roadmap

### In-network reseed over I2P

- **Problem.** The server only reseeds over clearnet, so an operator who wants their reseed reachable from inside I2P — or a network where clearnet reachability is fragile — has no supported path.
- **Under consideration.** First-class in-network reseed support, reusing the sibling `f5m/i2p` router as the SAM provider.
- **Rests on.** Upstream’s I2P listener; a running `f5m/i2p` with SAM enabled.

### Onion listener with f5m/tor

- **Problem.** Reseeding over an onion service would let censored routers bootstrap without touching clearnet at all, but the upstream listener needs a Tor control port this image neither starts nor documents.
- **Under consideration.** An onion-service toggle that points the upstream Tor client at a shared `f5m/tor` instance and persists the onion key alongside the SU3 signing key.
- **Rests on.** Upstream’s onion listener; the sibling `f5m/tor` image as the egress Tor.
