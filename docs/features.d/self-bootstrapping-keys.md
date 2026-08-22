<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Self-bootstrapping signing keys

- First start generates the SU3 signing key automatically — no prompts, no manual steps.
- Keys persist in a volume and are never regenerated over an existing identity.
- A concurrent container sharing the volume cannot corrupt a half-written key.
- The signing certificate is ready to submit when registering the server with the I2P team.
