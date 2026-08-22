<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Paquetes de seeds frescos sin reinicios

- Los paquetes SU3 se regeneran a un intervalo configurable desde la netDb activa — sin cron ni reinicios.
- Las router infos obsoletas se excluyen según una edad máxima configurable.
- El tamaño de los paquetes se adapta al crecimiento de la netDb (router infos por archivo y número de archivos ajustables).

<!-- textlint-enable -->
