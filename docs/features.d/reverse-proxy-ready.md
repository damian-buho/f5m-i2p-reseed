<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Reverse-proxy ready

- Serves plain HTTP and trusts X-Forwarded-For, so TLS termination stays with Traefik or nginx.
- Client IPs keep working in rate limits and blacklists even behind the proxy.
- Standalone TLS is one environment variable away for proxy-less deployments.
- Discovered automatically by Traefik through Docker labels.
