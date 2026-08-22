<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Onion-listener із f5m/tor

- **Проблема.** Reseed через onion-сервіс дозволив би цензурованим роутерам стартувати взагалі без clearnet, але upstream-прапорець `--onion` потребує контрольного порту Tor, який цей образ ані запускає, ані документує.
- **На розгляді.** Перемикач `F5M_I2P_RESEED_ONION_ENABLED`, який спрямовує Tor-клієнт upstream на спільний екземпляр `f5m/tor` і зберігає onion-ключ поруч із ключем підпису SU3.
- **Спирається на.** Listener `--onion`/`--singleOnion` в upstream; образ-сусід `f5m/tor` як вихідний Tor.

<!-- textlint-enable -->
