#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

set -eou pipefail

# shellcheck source=/dev/null
. b19-i18n

if [ ! -x /usr/local/bin/reseed-tools ]
then
  b19-log bad "TEST" "$(_ "reseed-tools binary not found")"
  exit 1
fi

b19-log good "TEST" "$(_ "reseed-tools binary exists")"
