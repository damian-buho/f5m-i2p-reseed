#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

set -o pipefail
# shellcheck source=../tools.d/b19-i18n

  PORT="${F5M_I2P_RESEED_PORT}"

  # 429 counts as healthy: the web homepage is rate-limited (default 40/hour),
  # so a steady healthcheck exhausts its own IP budget while the server is fine.
  CODE=$(curl -s -o /dev/null -w '%{http_code}' "http://localhost:${PORT}/" 2>/dev/null)

  case "${CODE}" in
    2*|3*|429)
      b19-log good "HEALTH.D" "$(_p "Reseed server healthy on port %s (HTTP %s)" "${PORT}" "${CODE}")"
      exit 0
      ;;
    *)
      b19-log bad "HEALTH.D" "$(_p "Reseed server unhealthy on port %s (HTTP %s)" "${PORT}" "${CODE:-none}")"
      exit 1
      ;;
  esac
