<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Reseed усередині мережі I2P

- **Проблема.** Сервер робить reseed лише через clearnet, тож оператор, який хоче, щоб його reseed був досяжним зсередини I2P — або працює в мережі, де досяжність clearnet крихка — не має підтримуваного шляху; прапорець `--i2p` існує, але ніщо не моделює його SAM-адресу чи ключі.
- **На розгляді.** Підключення першого класу через `F5M_I2P_RESEED_I2P_ENABLED` зі змінною для SAM-адреси, використовуючи router-сусіда `f5m/i2p` як SAM-провайдера.
- **Спирається на.** Listener `--i2p` та обробку `reseed.i2pkeys` в upstream; запущений `f5m/i2p` із увімкненим SAM.

<!-- textlint-enable -->
