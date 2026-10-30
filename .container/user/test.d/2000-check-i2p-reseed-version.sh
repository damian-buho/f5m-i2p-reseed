#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

set -eou pipefail

  ACTUAL=$(get-i2p-reseed-version)
  EXPECTED=$(decomment < /deps/reseed-tools/version.deps)

  b19-assert equals "I2P_RESEED" "${EXPECTED}" "${ACTUAL}"
