<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Стійкість до зловживань усталено

- Завантаження пакетів seeds обмежені за IP клієнта, тож одна машина не може виснажити сервер.
- Відвідування вебсторінки лімітуються окремо від справжніх клієнтів reseed.
- Необов'язковий файл чорного списку IP блокує зловживані адреси до того, як вони дістануться до seeds.

<!-- textlint-enable -->
