#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

set -o pipefail
# shellcheck source=/dev/null
. b19-i18n

  # Generate the SU3 signing key on first boot so the server never runs
  # without one and never prompts interactively. Idempotent: an existing
  # key is left untouched. Lock guards two containers sharing the volume.
  if [ -z "${F5M_I2P_RESEED_SIGNER}" ]
  then
    b19-log warn "RESEED" "$(_ "F5M_I2P_RESEED_SIGNER is empty, skipping key generation")"
    return 0
  fi

  KEYS_DIR="${F5M_I2P_RESEED_KEYS_DIR}"
  NETDB_DIR="${F5M_I2P_RESEED_NETDB}"
  SIGNER_FILE="${F5M_I2P_RESEED_SIGNER/@/_at_}"
  KEY_FILE="${KEYS_DIR}/${SIGNER_FILE}.pem"

  mkdir -p "${KEYS_DIR}" "${NETDB_DIR}"

  if [ -f "${KEY_FILE}" ]
  then
    b19-log good "RESEED" "$(_p "Signing key already present at %s" "${KEY_FILE}")"
    return 0
  fi

  b19-log info "RESEED" "$(_p "Generating SU3 signing key for %s in %s" "${F5M_I2P_RESEED_SIGNER}" "${KEYS_DIR}")"

  (
    flock --timeout 120 9 || exit 1
    cd "${KEYS_DIR}" && reseed-tools keygen --signer="${F5M_I2P_RESEED_SIGNER}"
  ) 9>"${KEYS_DIR}/.keygen.lock"

  if [ ! -f "${KEY_FILE}" ]
  then
    b19-log bad "RESEED" "$(_p "Key generation failed, no key at %s" "${KEY_FILE}")"
    return 1
  fi

  chmod 0600 "${KEY_FILE}"

  b19-log good "RESEED" "$(_p "Signing key ready at %s — publish %s to register the reseed server" "${KEY_FILE}" "${KEYS_DIR}/${SIGNER_FILE}.crt")"
