<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Abuse-resistant by default

- Seed bundle downloads are rate-limited per client IP, so one host cannot drain the server.
- Web homepage visits are throttled separately from actual reseeding clients.
- An optional IP blacklist file denies abusive addresses before they reach the seeds.
