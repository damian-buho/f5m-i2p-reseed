# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  # Upstream reseed-tools probes $HOME/i2p/i2prouter before ANY subcommand
  # (getmeanetdb.WhereIstheNetDB) and aborts when absent — even 'version'.
  # This marker file satisfies the probe; serving uses --netdb explicitly.
  b19-run "RESEED" "$(_ "Creating I2P probe marker")" --    \
    mkdir --parents "${B19_HOME}/i2p"

  b19-run "RESEED" "$(_ "Marking I2P probe file executable")" --    \
    touch "${B19_HOME}/i2p/i2prouter"

  chown "${B19_UID}:${B19_GID}" "${B19_HOME}/i2p" "${B19_HOME}/i2p/i2prouter"
