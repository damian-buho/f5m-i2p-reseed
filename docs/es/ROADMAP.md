<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

[English](../../ROADMAP.md) · [Українська](../uk/ROADMAP.md)

# Hoja de ruta

## Hoja de ruta del proyecto

### Reseed dentro de la red I2P

- **Problema.** El servidor solo hace reseed por la clearnet, así que un operador que quiera su reseed alcanzable desde dentro de I2P — o una red donde la alcanzabilidad por clearnet es frágil — no tiene un camino soportado; la opción `--i2p` existe pero nada modela su punto SAM ni sus claves.
- **Bajo consideración.** Conexión de primera clase mediante `F5M_I2P_RESEED_I2P_ENABLED` con una variable para la dirección SAM, reutilizando el router hermano `f5m/i2p` como proveedor SAM.
- **Se apoya en.** El listener `--i2p` y el manejo de `reseed.i2pkeys` del upstream; un `f5m/i2p` en marcha con SAM activado.

### Listener onion con f5m/tor

- **Problema.** Hacer reseed sobre un servicio onion permitiría a routers censurados arrancar sin tocar la clearnet, pero la opción `--onion` del upstream necesita un puerto de control de Tor que esta imagen ni arranca ni documenta.
- **Bajo consideración.** Un interruptor `F5M_I2P_RESEED_ONION_ENABLED` que apunte el cliente Tor del upstream a una instancia compartida de `f5m/tor` y persista la clave onion junto a la clave de firma SU3.
- **Se apoya en.** Los listeners `--onion`/`--singleOnion` del upstream; la imagen hermana `f5m/tor` como Tor de salida.
<!-- textlint-enable -->
