<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Onion listener with f5m/tor

- **Problem.** Reseeding over an onion service would let censored routers bootstrap without touching clearnet at all, but the upstream listener needs a Tor control port this image neither starts nor documents.
- **Under consideration.** An onion-service toggle that points the upstream Tor client at a shared `f5m/tor` instance and persists the onion key alongside the SU3 signing key.
- **Rests on.** Upstream’s onion listener; the sibling `f5m/tor` image as the egress Tor.
