<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Claves de firma auto-generadas

- El primer arranque genera la clave de firma SU3 automáticamente — sin preguntas ni pasos manuales.
- Las claves persisten en un volumen y nunca se regeneran sobre una identidad existente.
- Un contenedor concurrente que comparta el volumen no puede corromper una clave escrita a medias.
- El certificado de firma queda listo para presentarlo al registrar el servidor ante el equipo de I2P.

<!-- textlint-enable -->
