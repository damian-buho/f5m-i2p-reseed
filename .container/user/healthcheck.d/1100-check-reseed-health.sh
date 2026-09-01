#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

set -o pipefail
# shellcheck source=../tools.d/b19-i18n

  PORT="${F5M_I2P_RESEED_PORT}"
  TMP=$(mktemp)
  trap 'rm -f "${TMP}" "${TMP}.h"' EXIT

  # Fetch /i2pseeds.su3 with the I2P router User-Agent. The server requires
  # `Wget/1.11.4` (the upstream `I2pUserAgent` constant) — anything else gets
  # 403 from `verifyMiddleware`. With the right UA we receive a real signed
  # SU3 file (or HTTP 5xx when the in-memory cache is empty, e.g. netDb not
  # yet populated — a real boot failure we want to catch). The SU3 rate-limit
  # in --ratelimit is scaled by NUMPROCS in 5000-start.sh so the in-container
  # 30 s probe never exhausts the localhost budget.
  HTTP=$(curl -sS --max-time 10 -D "${TMP}.h" -o "${TMP}" \
    -A "Wget/1.11.4" \
    -w '%{http_code}' \
    "http://localhost:${PORT}/i2pseeds.su3" 2>/dev/null) || HTTP="000"

  VERSION=$(awk 'tolower($1) == "version:" { sub(/\r$/, "", $2); print $2; exit }' "${TMP}.h")
  SIZE=$(stat -c '%s' "${TMP}" 2>/dev/null || echo 0)

  if [ "${HTTP}" != "200" ]; then
    b19-log bad "HEALTH.D" "$(_p "Reseed server unhealthy: /i2pseeds.su3 returned HTTP %s (size %s, reseed-tools %s)" "${HTTP}" "${SIZE}" "${VERSION:-none}")"
    exit 1
  fi

  if [ -z "${VERSION}" ]; then
    b19-log bad "HEALTH.D" "$(_p "Reseed server unhealthy: missing Version header (HTTP %s, size %s)" "${HTTP}" "${SIZE}")"
    exit 1
  fi

  if [ "${SIZE}" -lt 64 ]; then
    b19-log bad "HEALTH.D" "$(_p "Reseed server unhealthy: SU3 too small (%s bytes)" "${SIZE}")"
    exit 1
  fi

  # 40 header bytes as hex (offsets 0..39), no address column. Layout per
  # upstream `su3.BodyBytes` (big-endian):
  #   0..5   magic "I2Psu3"
  #   25     FileType (0 = ZIP)
  #   27     ContentType (3 = Reseed)
  HDR=$(od --address-radix=n --format=x1 --read-bytes=40 "${TMP}" 2>/dev/null | tr -d ' \n')

  MAGIC="${HDR:0:12}"       # bytes 0..5
  FILETYPE="${HDR:50:2}"    # byte 25
  CONTENTTYPE="${HDR:54:2}" # byte 27

  if [ "${MAGIC}" != "493250737533" ]; then
    b19-log bad "HEALTH.D" "$(_p "Reseed server unhealthy: bad SU3 magic on /i2pseeds.su3 (size %s)" "${SIZE}")"
    exit 1
  fi

  if [ "${FILETYPE}" != "00" ]; then
    b19-log bad "HEALTH.D" "$(_p "Reseed server unhealthy: expected ZIP (0), got FileType %s" "${FILETYPE}")"
    exit 1
  fi

  if [ "${CONTENTTYPE}" != "03" ]; then
    b19-log bad "HEALTH.D" "$(_p "Reseed server unhealthy: expected Reseed (3), got ContentType %s" "${CONTENTTYPE}")"
    exit 1
  fi

  # The ZIP body sits after header (40 B) + version (16 B min) + signerID (variable
  # but < 256 B). Scan the first 256 bytes for the ZIP local-file-header magic
  # to confirm the embedded payload is a real routerInfo archive, not garbage.
  if ! od --address-radix=n --format=x1 --read-bytes=256 "${TMP}" 2>/dev/null \
       | tr -d ' \n' | grep -q "504b0304"; then
    b19-log bad "HEALTH.D" "$(_p "Reseed server unhealthy: SU3 body is not a ZIP (size %s)" "${SIZE}")"
    exit 1
  fi

  b19-log good "HEALTH.D" "$(_p "Reseed server healthy on port %s (HTTP 200, %s bytes, reseed-tools %s)" "${PORT}" "${SIZE}" "${VERSION}")"
  exit 0
