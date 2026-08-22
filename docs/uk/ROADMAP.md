<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

[English](../../ROADMAP.md) · [Español](../es/ROADMAP.md)

# Дорожня карта

## Дорожня карта проєкту

### Reseed усередині мережі I2P

- **Проблема.** Сервер робить reseed лише через clearnet, тож оператор, який хоче, щоб його reseed був досяжним зсередини I2P — або працює в мережі, де досяжність clearnet крихка — не має підтримуваного шляху; прапорець `--i2p` існує, але ніщо не моделює його SAM-адресу чи ключі.
- **На розгляді.** Підключення першого класу через `F5M_I2P_RESEED_I2P_ENABLED` зі змінною для SAM-адреси, використовуючи router-сусіда `f5m/i2p` як SAM-провайдера.
- **Спирається на.** Listener `--i2p` та обробку `reseed.i2pkeys` в upstream; запущений `f5m/i2p` із увімкненим SAM.

### Onion-listener із f5m/tor

- **Проблема.** Reseed через onion-сервіс дозволив би цензурованим роутерам стартувати взагалі без clearnet, але upstream-прапорець `--onion` потребує контрольного порту Tor, який цей образ ані запускає, ані документує.
- **На розгляді.** Перемикач `F5M_I2P_RESEED_ONION_ENABLED`, який спрямовує Tor-клієнт upstream на спільний екземпляр `f5m/tor` і зберігає onion-ключ поруч із ключем підпису SU3.
- **Спирається на.** Listener `--onion`/`--singleOnion` в upstream; образ-сусід `f5m/tor` як вихідний Tor.
<!-- textlint-enable -->
