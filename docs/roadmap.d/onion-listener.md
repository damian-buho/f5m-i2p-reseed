<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Onion listener with f5m/tor

- **Problem.** Reseeding over an onion service would let censored routers bootstrap without touching clearnet at all, but the upstream `--onion` flag needs a Tor control port this image neither starts nor documents.
- **Under consideration.** An `F5M_I2P_RESEED_ONION_ENABLED` toggle that points upstream’s Tor client at a shared `f5m/tor` instance and persists the onion key next to the SU3 signing key.
- **Rests on.** Upstream’s `--onion`/`--singleOnion` listeners; the sibling `f5m/tor` image as the egress Tor.
