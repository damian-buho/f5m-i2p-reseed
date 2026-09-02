<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# In-network reseed over I2P

- **Problem.** The server only reseeds over clearnet, so an operator who wants their reseed reachable from inside I2P — or a network where clearnet reachability is fragile — has no supported path.
- **Under consideration.** First-class in-network reseed support, reusing the sibling `f5m/i2p` router as the SAM provider.
- **Rests on.** Upstream’s I2P listener; a running `f5m/i2p` with SAM enabled.
