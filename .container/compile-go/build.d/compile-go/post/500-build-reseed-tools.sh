#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  export CGO_ENABLED=0

  b19-run "RESEED" "$(_ "Download modules")" --   \
    go mod download

  b19-run "RESEED" "$(_ "Build")" --    \
    go build -ldflags="-s -w" -o reseed-tools

  b19-strip "RESEED" reseed-tools

  b19-run "RESEED" "$(_ "Make directory in export")" --   \
    mkdir -p /export/usr/local/bin

  b19-run "RESEED" "$(_ "Copy executable to export")" --    \
    cp reseed-tools /export/usr/local/bin
