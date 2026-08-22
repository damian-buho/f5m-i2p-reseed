<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Готовий до зворотного проксі

- Слугує звичайним HTTP і довіряє X-Forwarded-For, тож завершення TLS залишається за Traefik або nginx.
- IP клієнтів продовжують працювати в лімітах швидкості та чорних списках за проксі.
- Автономний TLS — за одну змінну середовища для розгортань без проксі.
- Traefik виявляє його автоматично через мітки Docker.

<!-- textlint-enable -->
