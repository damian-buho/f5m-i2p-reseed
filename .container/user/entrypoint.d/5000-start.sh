#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  if [ "${ENTRYPOINT_COMMAND_EXECUTED:-N}" = "N" ]
  then
    if [ -z "${F5M_I2P_RESEED_SIGNER}" ]
    then
      b19-log bad "RESEED" "$(_ "F5M_I2P_RESEED_SIGNER is required (su3 signing ID, ex. admin@example.com)")"
      exit 1
    fi

    KEYS_DIR="${F5M_I2P_RESEED_KEYS_DIR}"
    SIGNER_FILE="${F5M_I2P_RESEED_SIGNER/@/_at_}"

    b19-log info "RESEED" "$(_p "Starting reseed server on %s:%s (signer %s)" "${F5M_I2P_RESEED_IP}" "${F5M_I2P_RESEED_PORT}" "${F5M_I2P_RESEED_SIGNER}")"

    # --ratelimit is the public per-IP anti-abuse bucket for /i2pseeds.su3 —
    # never scale it by NUMPROCS, an infra knob with no security meaning.
    # The healthcheck avoids exhausting it by caching its own probe result;
    # see 1100-check-reseed-health.sh.
    b19-log info "RESEED" "$(_p "SU3 rate limit %s/h" "${F5M_I2P_RESEED_RATELIMIT}")"

    # --yes keeps first boot non-interactive (self-signed TLS generation)
    args=(--yes
          --signer="${F5M_I2P_RESEED_SIGNER}"
          --key="${KEYS_DIR}/${SIGNER_FILE}.pem"
          --netdb="${F5M_I2P_RESEED_NETDB}"
          --ip="${F5M_I2P_RESEED_IP}"
          --port="${F5M_I2P_RESEED_PORT}"
          --numRi "${F5M_I2P_RESEED_NUM_RI}"
          --numSu3 "${F5M_I2P_RESEED_NUM_SU3}"
          --interval="${F5M_I2P_RESEED_INTERVAL}"
          --routerInfoAge="${F5M_I2P_RESEED_ROUTER_INFO_AGE}"
          --ratelimit "${F5M_I2P_RESEED_RATELIMIT}"
          --ratelimitweb "${F5M_I2P_RESEED_RATELIMITWEB}")

    if [ "${F5M_I2P_RESEED_TRUST_PROXY}" = "true" ]
    then
      args+=(--trustProxy)
    fi

    # Optional flags: appended only when set
    [ -n "${F5M_I2P_RESEED_TLS_HOST}" ]   && args+=(--tlsHost="${F5M_I2P_RESEED_TLS_HOST}")
    [ -n "${F5M_I2P_RESEED_PREFIX}" ]     && args+=(--prefix="${F5M_I2P_RESEED_PREFIX}")
    [ -n "${F5M_I2P_RESEED_BLACKLIST}" ]  && args+=(--blacklist="${F5M_I2P_RESEED_BLACKLIST}")
    [ -n "${F5M_I2P_RESEED_STATS}" ]      && args+=(--stats="${F5M_I2P_RESEED_STATS}")

    # shellcheck disable=SC2206
    [ -n "${F5M_I2P_RESEED_ARGS}" ]       && args+=(${F5M_I2P_RESEED_ARGS})

    b19-exec --     \
      reseed-tools reseed "${args[@]}"
  fi
