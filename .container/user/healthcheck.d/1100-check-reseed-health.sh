#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

set -o pipefail
# shellcheck source=../tools.d/b19-i18n

  PORT="${F5M_I2P_RESEED_PORT}"

  # /i2pseeds.su3 is gated by the server's own public per-IP SU3 rate limit
  # (F5M_I2P_RESEED_RATELIMIT, upstream default 4/h) — the same bucket a real
  # I2P router draws from. Docker probes this script every 10 s (360/h); a
  # real fetch on every probe drains localhost's bucket within a minute and
  # the server starts answering 429, which reads as a false unhealthy. Cache
  # only a SUCCESSFUL fetch and skip the real request while it is fresh — a
  # failure (startup, netDb empty, connection refused) never reaches the
  # rate limiter and costs it nothing, so it is always retried for real,
  # never cached, keeping outage detection fast.
  CACHE_FILE="${B19_TEMP_PATH:-/tmp}/.reseed-health-cache"
  CACHE_TTL=$(( 3600 / F5M_I2P_RESEED_RATELIMIT + 30 ))

  exec 9>"${CACHE_FILE}.lock"
  if ! flock --timeout 5 9; then
    b19-log bad "HEALTH.D" "$(_p "Reseed health cache lock timed out on %s" "${CACHE_FILE}.lock")"
    exit 1
  fi

  if [ -f "${CACHE_FILE}" ]; then
    # shellcheck disable=SC1090
    . "${CACHE_FILE}"
    NOW=$(date +%s)
    if [ -n "${CACHE_AT:-}" ] && [ $(( NOW - CACHE_AT )) -lt "${CACHE_TTL}" ]; then
      b19-log good "HEALTH.D" "$(_p "%s (cached, %ss old)" "${CACHE_LOG}" "$(( NOW - CACHE_AT ))")"
      exit 0
    fi
  fi

  TMP=$(mktemp)
  trap 'rm -f "${TMP}" "${TMP}.h"' EXIT

  # Fetch /i2pseeds.su3 with the I2P router User-Agent. The server requires
  # `Wget/1.11.4` (the upstream `I2pUserAgent` constant) — anything else gets
  # 403 from `verifyMiddleware`. With the right UA we receive a real signed
  # SU3 file (or HTTP 5xx when the in-memory cache is empty, e.g. netDb not
  # yet populated — a real boot failure we want to catch).
  HTTP=$(curl -sS --max-time 10 -D "${TMP}.h" -o "${TMP}" \
    -A "Wget/1.11.4" \
    -w '%{http_code}' \
    "http://localhost:${PORT}/i2pseeds.su3" 2>/dev/null) || HTTP="000"

  VERSION=$(awk 'tolower($1) == "version:" { sub(/\r$/, "", $2); print $2; exit }' "${TMP}.h" 2>/dev/null)
  SIZE=$(stat -c '%s' "${TMP}" 2>/dev/null || echo 0)

  # Logs the verdict; only a success ($1=0) is cached for CACHE_TTL.
  cache_and_exit() {
    if [ "$1" = 0 ]; then
      {
        printf 'CACHE_AT=%s\n' "$(date +%s)"
        printf 'CACHE_LOG=%q\n' "$2"
      } > "${CACHE_FILE}"
      b19-log good "HEALTH.D" "$2"
    else
      b19-log bad "HEALTH.D" "$2"
    fi
    exit "$1"
  }

  if [ "${HTTP}" != "200" ]; then
    cache_and_exit 1 "$(_p "Reseed server unhealthy: /i2pseeds.su3 returned HTTP %s (size %s, reseed-tools %s)" "${HTTP}" "${SIZE}" "${VERSION:-none}")"
  fi

  if [ -z "${VERSION}" ]; then
    cache_and_exit 1 "$(_p "Reseed server unhealthy: missing Version header (HTTP %s, size %s)" "${HTTP}" "${SIZE}")"
  fi

  if [ "${SIZE}" -lt 64 ]; then
    cache_and_exit 1 "$(_p "Reseed server unhealthy: SU3 too small (%s bytes)" "${SIZE}")"
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
    cache_and_exit 1 "$(_p "Reseed server unhealthy: bad SU3 magic on /i2pseeds.su3 (size %s)" "${SIZE}")"
  fi

  if [ "${FILETYPE}" != "00" ]; then
    cache_and_exit 1 "$(_p "Reseed server unhealthy: expected ZIP (0), got FileType %s" "${FILETYPE}")"
  fi

  if [ "${CONTENTTYPE}" != "03" ]; then
    cache_and_exit 1 "$(_p "Reseed server unhealthy: expected Reseed (3), got ContentType %s" "${CONTENTTYPE}")"
  fi

  # The ZIP body sits after header (40 B) + version (16 B min) + signerID (variable
  # but < 256 B). Scan the first 256 bytes for the ZIP local-file-header magic
  # to confirm the embedded payload is a real routerInfo archive, not garbage.
  if ! od --address-radix=n --format=x1 --read-bytes=256 "${TMP}" 2>/dev/null \
       | tr -d ' \n' | grep -q "504b0304"; then
    cache_and_exit 1 "$(_p "Reseed server unhealthy: SU3 body is not a ZIP (size %s)" "${SIZE}")"
  fi

  cache_and_exit 0 "$(_p "Reseed server healthy on port %s (HTTP 200, %s bytes, reseed-tools %s)" "${PORT}" "${SIZE}" "${VERSION}")"
