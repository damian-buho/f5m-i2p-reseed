<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Listo para proxy inverso

- Sirve HTTP plano y confía en X-Forwarded-For, de modo que la terminación TLS queda en Traefik o nginx.
- Las IP de los clientes siguen funcionando en los límites de tasa y las listas negras tras el proxy.
- El TLS autónomo está a una variable de entorno de distancia para despliegues sin proxy.
- Traefik lo descubre automáticamente mediante etiquetas Docker.

<!-- textlint-enable -->
