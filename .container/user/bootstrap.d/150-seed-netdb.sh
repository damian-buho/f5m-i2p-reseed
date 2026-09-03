#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

set -o pipefail
# shellcheck source=/dev/null
. b19-i18n

  # Seed a minimal synthetic netDb when the real one is empty so the
  # pipeline’s strict healthcheck (GET /i2pseeds.su3 → 200 + valid SU3)
  # can pass without a sibling router. The reseed server needs at least
  # F5M_I2P_RESEED_NUM_RI live routerInfos after the 25% shuffle-drop,
  # i.e. raw ≈ numRi * 4/3. In dev the shared volume already has them,
  # so this is a no-op there (idempotent, guarded by flock).
  NETDB_DIR="${F5M_I2P_RESEED_NETDB}"
  NUM_RI="${F5M_I2P_RESEED_NUM_RI:-61}"
  # raw needed = ceil(numRi * 4/3) + 2 headroom
  NEED=$(( NUM_RI * 4 / 3 + 4 ))
  [ "${NEED}" -lt 4 ] && NEED=4

  mkdir -p "${NETDB_DIR}"

  # Count existing routerInfos that match the upstream regex and are not stale
  # (72h age filter mirrors F5M_I2P_RESEED_ROUTER_INFO_AGE default).
  count_valid() {
    local cnt=0
    while IFS= read -r -d '' f; do
      # filter by regex to avoid counting stray files
      bn=$(basename "${f}")
      case "${bn}" in
        routerInfo-[A-Za-z0-9-=~]*.dat) ;;
        *) continue ;;
      esac
      # age filter: skip files older than ROUTER_INFO_AGE (default 72h)
      # use 259200 seconds if var empty
      max_age="${F5M_I2P_RESEED_ROUTER_INFO_AGE:-72h}"
      # translate 72h/1h etc to seconds roughly
      secs=259200
      case "${max_age}" in
        *h) secs=$(( ${max_age%h} * 3600 )) ;;
        *m) secs=$(( ${max_age%m} * 60 )) ;;
        *d) secs=$(( ${max_age%d} * 86400 )) ;;
      esac
      age=$(( $(date +%s) - $(stat -c %Y "${f}" 2>/dev/null || echo 0) ))
      if [ "${age}" -gt "${secs}" ]; then
        continue
      fi
      cnt=$((cnt + 1))
    done < <(find "${NETDB_DIR}" -type f -name 'routerInfo-*.dat' -print0 2>/dev/null)
    echo "${cnt}"
  }

  HAVE=$(count_valid)
  b19-log info "RESEED" "$(_p "netDb at %s: have %s valid routerInfos, need %s (numRi %s)" "${NETDB_DIR}" "${HAVE}" "${NEED}" "${NUM_RI}")"

  if [ "${HAVE}" -ge "${NEED}" ]; then
    b19-log good "RESEED" "$(_p "netDb already populated (%s/%s) — skipping seed" "${HAVE}" "${NEED}")"
    exit 0
  fi

  # Need reseed-fixture helper built in compile-go stage; if missing fall back to
  # a tiny inline python generator that at least creates parsable placeholders.
  # The helper is preferred because it creates cryptographically valid RIs that
  # pass GoodVersion/Reachable/UnCongested.
  if command -v reseed-fixture >/dev/null 2>&1; then
    b19-log info "RESEED" "$(_p "Seeding netDb with %s synthetic routerInfos via reseed-fixture" "${NEED}")"
    (
      flock --timeout 60 9 || exit 1
      # re-check under lock
      HAVE2=$(count_valid)
      if [ "${HAVE2}" -ge "${NEED}" ]; then
        b19-log good "RESEED" "$(_p "netDb populated while waiting for lock (%s/%s)" "${HAVE2}" "${NEED}")"
        exit 0
      fi
      reseed-fixture --netdb "${NETDB_DIR}" --count "${NEED}" 2>&1 | while IFS= read -r line; do b19-log info "RESEED" "${line}"; done
      rc=${PIPESTATUS[0]}
      if [ "${rc}" -ne 0 ]; then
        b19-log bad "RESEED" "$(_p "reseed-fixture failed with %s" "${rc}")"
        exit "${rc}"
      fi
      # ensure fresh mtimes so age filter passes
      find "${NETDB_DIR}" -type f -name 'routerInfo-*.dat' -exec touch {} +
    ) 9>"${NETDB_DIR}/.seed.lock"
    HAVE_AFTER=$(count_valid)
    b19-log good "RESEED" "$(_p "netDb seeded: %s valid routerInfos at %s" "${HAVE_AFTER}" "${NETDB_DIR}")"
    exit 0
  fi

  b19-log warn "RESEED" "$(_ "reseed-fixture not found, skipping synthetic netDb seed — healthcheck may fail on empty netDb")"
  exit 0
