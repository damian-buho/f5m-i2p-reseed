<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
pf-cli-managed: yes
-->

<!-- textlint-disable terminology,common-misspellings -->

[English](../../README.md) · [Українська](../uk/README.md)

# F5M / I2P Reseed

Servidor reseed de I2P que distribuye bundles SU3 firmados, con claves al primer arranque, endpoints limitados y sonda de vida.

[![Stand with Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://damian-buho.github.io/support-ukraine/) [![Projectfile inside](https://badges.kiota.ch/static/v1?label=projectfile&message=inside&labelColor=0d0d0d&color=8c6723&style=flat-square)](https://projectfile.org) [![License](https://badges.kiota.ch/static/v1?label=license&message=MIT&color=1e5913&style=flat-square)](LICENSE) [![Cosign](https://badges.kiota.ch/static/v1?label=cosign&message=enabled&color=1e5913&style=flat-square)](https://docs.sigstore.dev/cosign/verifying/verify/) ![ClamAV scanned](https://badges.kiota.ch/static/v1?label=clamav&message=scanned&color=1877aa&style=flat-square) [![PRs welcome](https://badges.kiota.ch/static/v1?label=PRs&message=welcome&color=1e5913&style=flat-square)](CONTRIBUTING.md) [![REUSE compliance](https://api.reuse.software/badge/github.com/damian-buho/f5m-i2p-reseed)](https://api.reuse.software/info/github.com/damian-buho/f5m-i2p-reseed)

![Project status](https://badges.kiota.ch/static/v1?label=status&message=maintained&color=1d63ed&style=flat-square) [![Last commit on GitHub](https://badges.kiota.ch/github/last-commit/damian-buho/f5m-i2p-reseed?label=last%20commit%20on%20GitHub&style=flat-square)](https://github.com/damian-buho/f5m-i2p-reseed) [![Last commit on kiota.ch](https://badges.kiota.ch/gitea/last-commit/f5m/i2p-reseed?gitea_url=https://kiota.ch&label=last%20commit%20on%20kiota.ch&style=flat-square)](https://kiota.ch/f5m/i2p-reseed)

[![Publish pipeline on GitHub](https://github.com/damian-buho/f5m-i2p-reseed/actions/workflows/published.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/f5m-i2p-reseed/actions) [![Vulnerability audit on GitHub](https://github.com/damian-buho/f5m-i2p-reseed/actions/workflows/audited.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/f5m-i2p-reseed/actions) [![Dependency freshness on GitHub](https://github.com/damian-buho/f5m-i2p-reseed/actions/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/f5m-i2p-reseed/actions) [![Analysis sweep on GitHub](https://github.com/damian-buho/f5m-i2p-reseed/actions/workflows/analyzed.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/f5m-i2p-reseed/actions)

[![Publish pipeline on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/published.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions) [![Vulnerability audit on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/audited.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions) [![Dependency freshness on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions) [![Analysis sweep on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/analyzed.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions)

## Características

- Resistente al abuso por defecto
- Paquetes de seeds frescos sin reinicios
- Listo para proxy inverso
- Claves de firma auto-generadas

También hereda las características de B19 / Ubuntu; consulta [Características](FEATURES.md) para ver la lista completa.

## Inicio rápido

Guarda esto como `compose.yaml`:

```yaml
---
services:
  i2p-reseed:
    image: docker.io/damianbuho/f5m-i2p-reseed:latest
    ports:
      - "8080:8080"
    environment:
      F5M_I2P_RESEED_SIGNER: change-me@mail.i2p
    volumes:
      - i2p:/app/.i2p
      - i2p-reseed:/app/data
    cap_drop: [ALL]
    security_opt: [no-new-privileges:true]
    restart: unless-stopped
  i2p:
    image: docker.io/damianbuho/f5m-i2p:latest
    volumes:
      - i2p:/app/.i2p
    cap_drop: [ALL]
    security_opt: [no-new-privileges:true]
    restart: unless-stopped
volumes:
  i2p:
  i2p-reseed:
```

Después, arráncalo con `docker compose up --detach`.

## Qué entrega este proyecto

- **Servicio** `i2p-reseed` — escucha en `8080 (http)` — Servidor de resiembra I2P
- **Imagen de contenedor** `ghcr.io/damian-buho/f5m/i2p-reseed:latest`
- **Imagen de contenedor** `damianbuho/f5m-i2p-reseed:latest`

## Instalación

Descarga la imagen de contenedor publicada:

### Descargar de GHCR — linux/amd64

```sh
docker pull ghcr.io/damian-buho/f5m/i2p-reseed:latest
```

### Descargar de DockerHub — linux/amd64

```sh
docker pull damianbuho/f5m-i2p-reseed:latest
```

Las versiones estables también publican las etiquetas `X.Y.Z`, `X.Y` y `X`: descarga el nivel de precisión que quieras fijar.

Si los registros anteriores no están disponibles, descarga desde el origen:

### Descargar de Kiota — linux/amd64

```sh
docker pull kiota.ch/f5m/i2p-reseed:latest
```

## Uso

Ejecuta el servicio en segundo plano, publicando sus puertos:

### Desde GHCR

```sh
docker run --detach --publish 8080:8080/tcp ghcr.io/damian-buho/f5m/i2p-reseed:latest
```

### Desde DockerHub

```sh
docker run --detach --publish 8080:8080/tcp damianbuho/f5m-i2p-reseed:latest
```

Después, comprueba que responde:

```sh
curl http://localhost:8080/i2pseeds.su3
```

## Compilación

Clona el repositorio con sus submódulos:

```sh
git clone --recurse-submodules https://github.com/damian-buho/f5m-i2p-reseed i2p-reseed && cd i2p-reseed
```

Construye la imagen de contenedor en local:

```sh
make container-build
```

- [Referencia del Makefile](../how-to/MAKEFILE.md)

Ejecuta `make` sin argumentos para el destino predeterminado; ejecuta `make help` para listar todos los destinos.

Para el bucle de desarrollo local, `make dev-container` levanta el dev-container.

Puntos de entrada de la canalización:

- `make analyzed` — Ejecuta el análisis pesado (pruebas de mutación, benchmarks)
- `make audited` — Vuelve a escanear las dependencias fijadas y los artefactos publicados en busca de vulnerabilidades nuevas
- `make check-outdated` — Informa de cada dependencia fijada que va por detrás de su versión upstream
- `make release-is-ready` — Ejecuta localmente el pipeline pseudo-CI — compila, prueba y escanea, sin publicar

## Hoja de ruta

Consulta la [Hoja de ruta](../ROADMAP.md) para ver lo que viene.

## Políticas

- [Cómo contribuir](CONTRIBUTING.md)
- [Política de seguridad](SECURITY.md)
- [Cómo obtener ayuda](SUPPORT.md)
- [Código de conducta](CODE_OF_CONDUCT.md)
- [Política sobre IA y LLM](AI_POLICY.md)

## Enlaces

- [Especificación de Projectfile](https://projectfile.org)

Proyectos relacionados: [F5M/Tor](https://kiota.ch/f5m/tor) | [F5M/I2P](https://kiota.ch/f5m/i2p) | [F5M/Tor Snowflake](https://kiota.ch/f5m/tor-snowflake) | [F5M/OONI Probe](https://kiota.ch/f5m/ooni) | [F5M/Knot](https://kiota.ch/f5m/knot) | [F5M/Radicle](https://kiota.ch/f5m/radicle) | [F5M/Solid](https://kiota.ch/f5m/solid) | [F5M/SSH](https://kiota.ch/f5m/ssh)

## Licencia

Este proyecto se publica bajo la licencia MIT — consulta el archivo [LICENSE](LICENSE) para más detalles.

<!-- textlint-enable -->
