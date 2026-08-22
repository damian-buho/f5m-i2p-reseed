<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# In-network reseed over I2P

- **Problem.** The server only reseeds over clearnet, so an operator who wants their reseed reachable from inside I2P — or a network where clearnet reachability is fragile — has no supported path; the raw `--i2p` flag exists but nothing models its SAM endpoint or keys.
- **Under consideration.** First-class `F5M_I2P_RESEED_I2P_ENABLED` wiring with a SAM address env, reusing the sibling `f5m/i2p` router as the SAM provider.
- **Rests on.** Upstream’s `--i2p` listener and `reseed.i2pkeys` handling; a running `f5m/i2p` with SAM enabled.
