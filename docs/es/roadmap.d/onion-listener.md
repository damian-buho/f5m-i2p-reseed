<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Listener onion con f5m/tor

- **Problema.** Hacer reseed sobre un servicio onion permitiría a routers censurados arrancar sin tocar la clearnet, pero la opción `--onion` del upstream necesita un puerto de control de Tor que esta imagen ni arranca ni documenta.
- **Bajo consideración.** Un interruptor `F5M_I2P_RESEED_ONION_ENABLED` que apunte el cliente Tor del upstream a una instancia compartida de `f5m/tor` y persista la clave onion junto a la clave de firma SU3.
- **Se apoya en.** Los listeners `--onion`/`--singleOnion` del upstream; la imagen hermana `f5m/tor` como Tor de salida.

<!-- textlint-enable -->
