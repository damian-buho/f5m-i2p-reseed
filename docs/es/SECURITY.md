<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
pf-cli-managed: yes
-->

<!-- textlint-disable terminology,common-misspellings -->
[English](../../SECURITY.md) · [Українська](../uk/SECURITY.md)

# Política de seguridad

## Cómo informar de una vulnerabilidad

**No informes de vulnerabilidades de seguridad a través de incidencias, debates o solicitudes de cambio públicos.**

Hazlo escribiendo a **<damian.buho@proton.me>**.

Incluye toda la información que puedas de la siguiente lista; nos ayuda a clasificar y resolver el informe más rápido:

- El tipo de problema (p. ej. desbordamiento de búfer, inyección SQL, cross-site scripting)
- La versión o versiones afectadas
- El impacto del problema, incluido cómo podría explotarlo un atacante
- Instrucciones paso a paso para reproducir el problema
- La ubicación del código fuente afectado (etiqueta, rama, commit o URL directa)
- Las rutas completas de los archivos fuente relacionados con el problema
- Cualquier configuración necesaria para reproducir el problema
- Archivos de registro relevantes, si es posible
- Código de prueba de concepto o de explotación, si es posible

Procuramos acusar recibo de los informes en un plazo de 30 días y coordinar
la divulgación en cuanto exista una corrección.

## Cifrar un informe

Si quieres enviarnos un informe cifrado, sigue estos pasos.

Importa nuestra clave pública:

```sh
gpg --keyserver keys.openpgp.org --recv-keys B64C122EE16C3746
```

Verifica que la huella coincide antes de confiar en ella:

```sh
gpg --fingerprint B64C122EE16C3746
```

La salida debe mostrar:

```text
6F19 7084 3C9E 8406 AD70  0467 B64C 122E E16C 3746
```

Cifra tu mensaje para nosotros:

```sh
gpg --encrypt --armor --recipient B64C122EE16C3746 message.txt
```

## Programa de recompensas

F5M/I2P Reseed no ofrece actualmente un programa de recompensas. Aun así
agradecemos los informes divulgados de forma responsable — consulta el canal de
contacto anterior.

## Vulnerabilidades reconocidas

Los siguientes hallazgos fueron revisados y se suprimen de forma intencionada
(la corrección depende de una versión posterior del proyecto base o el aviso no
aplica a este proyecto):

| ID | Motivo |
| --- | --- |
| CVE-2026-39827 | blocked by upstream |
| GHSA-45gg-vh54-h5m9 | blocked by upstream |
| GHSA-89gr-r52h-f8rx | blocked by upstream |
| GHSA-f5wc-c3c7-36mc | blocked by upstream |
| GHSA-q4h4-gmj2-qvw2 | blocked by upstream |
| GHSA-qpw4-5x99-6vjp | blocked by upstream |
| GHSA-rm3j-f69w-wqmq | blocked by upstream |
| GHSA-vgwf-h737-ff37 | blocked by upstream |
| GHSA-w879-237q-wc7r | blocked by upstream |
| GHSA-x527-x647-q7gg | blocked by upstream |
| CVE-2026-39828 | blocked by upstream |
| GO-2026-5014 | blocked by upstream |
| CVE-2026-39829 | blocked by upstream |
| GO-2026-5018 | blocked by upstream |
| CVE-2026-39830 | blocked by upstream |
| GO-2026-5017 | blocked by upstream |
| CVE-2026-39831 | blocked by upstream |
| GO-2026-5019 | blocked by upstream |
| CVE-2026-39832 | blocked by upstream |
| GO-2026-5006 | blocked by upstream |
| CVE-2026-39833 | blocked by upstream |
| GO-2026-5005 | blocked by upstream |
| CVE-2026-39834 | blocked by upstream |
| GO-2026-5020 | blocked by upstream |
| CVE-2026-39835 | blocked by upstream |
| GO-2026-5015 | blocked by upstream |
| CVE-2026-42508 | blocked by upstream |
| GO-2026-5021 | blocked by upstream |
| CVE-2026-46595 | blocked by upstream |
| GO-2026-5023 | blocked by upstream |
| CVE-2026-46597 | blocked by upstream |
| GO-2026-5013 | blocked by upstream |
| CVE-2026-56854 | blocked by upstream |
| GO-2026-6303 | blocked by upstream |
| CVE-2026-46600 | blocked by upstream |
| CVE-2026-25681 | blocked by upstream |
| CVE-2026-27136 | blocked by upstream |
| CVE-2026-33814 | blocked by upstream |
| GO-2026-4918 | blocked by upstream |
| CVE-2026-39821 | blocked by upstream |
| GO-2026-5026 | blocked by upstream |
| CVE-2026-39822 | blocked by upstream |
| CVE-2026-42502 | blocked by upstream |
| CVE-2026-56852 | blocked by upstream |
| GO-2026-5970 | blocked by upstream |
| CVE-2026-40611 | unfixable upstream dependency; fixable only via upstream release |

<!-- textlint-enable -->
