<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Свіжі пакети seeds без перезапусків

- Пакети SU3 перестворюються за налаштовуваним інтервалом із живої netDb — без cron і перезапусків.
- Застарілі router infos виключаються за конфігурною максимальною добою.
- Розмір пакетів адаптується до зростання netDb (router infos на файл і кількість файлів регулюються).

<!-- textlint-enable -->
