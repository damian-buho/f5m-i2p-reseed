<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Fresh seed bundles without restarts

- SU3 bundles are rebuilt on a configurable interval from the live netDb — no cron, no restarts.
- Stale router infos are excluded by a configurable maximum age.
- Bundle size adapts to netDb growth (router infos per file and file count are tunable).
