<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Reseed dentro de la red I2P

- **Problema.** El servidor solo hace reseed por la clearnet, así que un operador que quiera su reseed alcanzable desde dentro de I2P — o una red donde la alcanzabilidad por clearnet es frágil — no tiene un camino soportado; la opción `--i2p` existe pero nada modela su punto SAM ni sus claves.
- **Bajo consideración.** Conexión de primera clase mediante `F5M_I2P_RESEED_I2P_ENABLED` con una variable para la dirección SAM, reutilizando el router hermano `f5m/i2p` como proveedor SAM.
- **Se apoya en.** El listener `--i2p` y el manejo de `reseed.i2pkeys` del upstream; un `f5m/i2p` en marcha con SAM activado.

<!-- textlint-enable -->
