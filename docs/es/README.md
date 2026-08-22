<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
pf-cli-managed: yes
-->

<!-- textlint-disable terminology,common-misspellings -->

[English](../../README.md) · [Українська](../uk/README.md)

# F5M/I2P Reseed

Distribución del servidor de reseed de I2P mantenida por la comunidad, basada en B19/Go

[![Stand with Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://damian-buho.github.io/support-ukraine/) [![Projectfile inside](https://badges.kiota.ch/badge/projectfile-inside-c99b46?style=flat-square)](https://projectfile.org) [![License](https://badges.kiota.ch/static/v1?label=license&message=MIT&color=4c1&style=flat-square)](LICENSE) ![Commit style](https://badges.kiota.ch/static/v1?label=commits&message=conventional&color=blue&style=flat-square) ![Workflow](https://badges.kiota.ch/static/v1?label=workflow&message=git-flow&color=blue&style=flat-square) ![Versioning](https://badges.kiota.ch/static/v1?label=versioning&message=semantic&color=blue&style=flat-square) [![PRs welcome](https://badges.kiota.ch/static/v1?label=PRs&message=welcome&color=4c1&style=flat-square)](CONTRIBUTING.md) [![Citation](https://badges.kiota.ch/static/v1?label=citation&message=cff&color=blue&style=flat-square)](CITATION.cff) [![REUSE compliance](https://api.reuse.software/badge/codeberg.org/f5m/i2p-reseed)](https://api.reuse.software/info/codeberg.org/f5m/i2p-reseed)

![Project status](https://badges.kiota.ch/static/v1?label=status&message=maintained&color=1d63ed&style=flat-square) [![Last commit on kiota.ch](https://badges.kiota.ch/gitea/last-commit/f5m/i2p-reseed?gitea_url=https://kiota.ch&style=flat-square)](https://kiota.ch/f5m/i2p-reseed)

[![Publish pipeline on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/published.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions) [![Vulnerability audit on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/audited.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions) [![Dependency freshness on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions) [![Analysis sweep on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/analyze.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions)

Proyectos relacionados: [F5M/Tor](https://kiota.ch/f5m/tor) | [F5M/I2P](https://kiota.ch/f5m/i2p) | [F5M/Tor Snowflake](https://kiota.ch/f5m/tor-snowflake) | [F5M/OONI Probe](https://kiota.ch/f5m/ooni) | [F5M/Knot](https://kiota.ch/f5m/knot) | [F5M/Radicle](https://kiota.ch/f5m/radicle) | [F5M/Solid](https://kiota.ch/f5m/solid) | [F5M/SSH](https://kiota.ch/f5m/ssh)

## Qué entrega este proyecto

- **Imagen de contenedor** `ghcr.io/damian-buho/f5m/i2p-reseed:latest`
- **Imagen de contenedor** `docker.io/damianbuho/f5m-i2p-reseed:latest`

## Instalación

Descarga la imagen de contenedor publicada:

### Descargar de GHCR

```sh
docker pull ghcr.io/damian-buho/f5m/i2p-reseed:latest
```

### Descargar de DockerHub

```sh
docker pull docker.io/damianbuho/f5m-i2p-reseed:latest
```

Las versiones estables también publican las etiquetas `X.Y.Z`, `X.Y` y `X`: descarga el nivel de precisión que quieras fijar.

Si los registros anteriores no están disponibles, descarga desde el origen:

### Descargar de Kiota

```sh
docker pull kiota.ch/f5m/i2p-reseed:latest
```

## Uso

Levanta la pila localmente:

```sh
make dc-up
make dc-logs
make dc-down
```

## Compilación

Ejecuta `make` sin argumentos para el destino predeterminado; ejecuta `make help` para listar todos los destinos.

Para el bucle de desarrollo local, `make dev-container` levanta el dev-container.

Puntos de entrada de la canalización:

- `make analyze` — Run the heavy analysis sweep (mutation testing, benchmarks)
- `make audited` — Re-scan the pinned dependencies and published artifacts for new vulnerabilities
- `make check-outdated` — Report every pinned dependency that lags upstream
- `make ready-to-publish` — Run the pseudo-CI pipeline locally — build, test and scan, without publishing

## Políticas

- [Cómo contribuir](CONTRIBUTING.md)
- [Política de seguridad](SECURITY.md)
- [Cómo obtener ayuda](SUPPORT.md)
- [Código de conducta](CODE_OF_CONDUCT.md)
- [Política sobre IA y LLM](AI_POLICY.md)

## Enlaces

- [Especificación de Projectfile](https://projectfile.org)

## Licencia

Este proyecto se publica bajo la licencia MIT — consulta el archivo [LICENSE](LICENSE) para más detalles.

<!-- textlint-enable -->
