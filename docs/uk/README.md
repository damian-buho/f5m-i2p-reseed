<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
pf-cli-managed: yes
-->

<!-- textlint-disable terminology,common-misspellings -->

[English](../../README.md) · [Español](../es/README.md)

# F5M / I2P Reseed

Дистрибуція reseed-tools від go-i2p з підтримкою спільноти, зібрана на основі B19/Go. Цей репозиторій містить лише пакування — Dockerfile, скрипти збирання та конфігурацію, усе під ліцензією MIT; оригінальні інструменти reseed-tools отримують під час збирання, і вони зберігають власну ліцензію.

[![Stand with Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://damian-buho.github.io/support-ukraine/) [![Projectfile inside](https://badges.kiota.ch/static/v1?label=projectfile&message=inside&labelColor=0d0d0d&color=8c6723&style=flat-square)](https://projectfile.org) [![License](https://badges.kiota.ch/static/v1?label=license&message=MIT&color=1e5913&style=flat-square)](LICENSE) [![PRs welcome](https://badges.kiota.ch/static/v1?label=PRs&message=welcome&color=1e5913&style=flat-square)](CONTRIBUTING.md) [![REUSE compliance](https://api.reuse.software/badge/github.com/damian-buho/f5m-i2p-reseed)](https://api.reuse.software/info/github.com/damian-buho/f5m-i2p-reseed)

![Project status](https://badges.kiota.ch/static/v1?label=status&message=maintained&color=1d63ed&style=flat-square) [![Last commit on GitHub](https://badges.kiota.ch/github/last-commit/damian-buho/f5m-i2p-reseed?label=last%20commit%20on%20GitHub&style=flat-square)](https://github.com/damian-buho/f5m-i2p-reseed) [![Last commit on kiota.ch](https://badges.kiota.ch/gitea/last-commit/f5m/i2p-reseed?gitea_url=https://kiota.ch&label=last%20commit%20on%20kiota.ch&style=flat-square)](https://kiota.ch/f5m/i2p-reseed)

[![Publish pipeline on GitHub](https://github.com/damian-buho/f5m-i2p-reseed/actions/workflows/published.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/f5m-i2p-reseed/actions) [![Vulnerability audit on GitHub](https://github.com/damian-buho/f5m-i2p-reseed/actions/workflows/audited.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/f5m-i2p-reseed/actions) [![Dependency freshness on GitHub](https://github.com/damian-buho/f5m-i2p-reseed/actions/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/f5m-i2p-reseed/actions) [![Analysis sweep on GitHub](https://github.com/damian-buho/f5m-i2p-reseed/actions/workflows/analyzed.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/f5m-i2p-reseed/actions)

[![Publish pipeline on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/published.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions) [![Vulnerability audit on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/audited.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions) [![Dependency freshness on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions) [![Analysis sweep on kiota.ch](https://kiota.ch/f5m/i2p-reseed/badges/workflows/analyze.yaml/badge.svg?style=flat-square)](https://kiota.ch/f5m/i2p-reseed/actions)

## Можливості

- Стійкість до зловживань усталено
- Свіжі пакети seeds без перезапусків
- Готовий до зворотного проксі
- Самостворювані ключі підпису

Також успадковує можливості B19 / Ubuntu — повний перелік див. у [Можливості](FEATURES.md).

## Швидкий старт

Збережіть це як `compose.yaml`:

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

Потім запустіть його командою `docker compose up --detach`.

## Що надає цей проєкт

- **Служба** `i2p-reseed` — слухає на `8080 (http)` — Сервер початкового заповнення I2P
- **Образ контейнера** `ghcr.io/damian-buho/f5m/i2p-reseed:latest`
- **Образ контейнера** `damianbuho/f5m-i2p-reseed:latest`

## Встановлення

Завантажте опублікований образ контейнера:

### Завантажити з GHCR — linux/amd64

```sh
docker pull ghcr.io/damian-buho/f5m/i2p-reseed:latest
```

### Завантажити з DockerHub — linux/amd64

```sh
docker pull damianbuho/f5m-i2p-reseed:latest
```

Стабільні випуски також публікують теґи `X.Y.Z`, `X.Y` і `X` — завантажте той рівень точності, який хочете зафіксувати.

Якщо наведені вище реєстри недоступні, завантажте з джерела:

### Завантажити з Kiota — linux/amd64

```sh
docker pull kiota.ch/f5m/i2p-reseed:latest
```

## Використання

Запустіть сервіс у фоновому режимі, опублікувавши його порти:

### З GHCR

```sh
docker run --detach --publish 8080:8080/tcp ghcr.io/damian-buho/f5m/i2p-reseed:latest
```

### З DockerHub

```sh
docker run --detach --publish 8080:8080/tcp damianbuho/f5m-i2p-reseed:latest
```

Потім перевірте, що він відповідає:

```sh
curl http://localhost:8080/i2pseeds.su3
```

## Збирання

Клонуйте репозиторій разом із підмодулями:

```sh
git clone --recurse-submodules https://github.com/damian-buho/f5m-i2p-reseed i2p-reseed && cd i2p-reseed
```

Зберіть образ контейнера локально:

```sh
make container-build
```

- [Довідник із Makefile](../how-to/MAKEFILE.md)

Виконайте `make` без аргументів для типової цілі; виконайте `make help`, щоб переглянути всі цілі.

Для локального циклу розробки `make dev-container` піднімає dev-container.

Точки входу конвеєра:

- `make analyzed` — Запускає важкий аналіз (мутаційне тестування, бенчмарки)
- `make audited` — Повторно сканує закріплені залежності й опубліковані артефакти на нові вразливості
- `make check-outdated` — Звітує про кожну закріплену залежність, що відстає від upstream
- `make ready-to-publish` — Запускає псевдо-CI локально — збирає, тестує й сканує без публікації

## Дорожня карта

Див. [Дорожня карта](../ROADMAP.md), щоб дізнатися про заплановане.

## Політики

- [Як зробити внесок](CONTRIBUTING.md)
- [Політика безпеки](SECURITY.md)
- [Як отримати підтримку](SUPPORT.md)
- [Кодекс поведінки](CODE_OF_CONDUCT.md)
- [Політика щодо ШІ та LLM](AI_POLICY.md)

## Посилання

- [Специфікація Projectfile](https://projectfile.org)

Пов’язані проєкти: [F5M/Tor](https://kiota.ch/f5m/tor) | [F5M/I2P](https://kiota.ch/f5m/i2p) | [F5M/Tor Snowflake](https://kiota.ch/f5m/tor-snowflake) | [F5M/OONI Probe](https://kiota.ch/f5m/ooni) | [F5M/Knot](https://kiota.ch/f5m/knot) | [F5M/Radicle](https://kiota.ch/f5m/radicle) | [F5M/Solid](https://kiota.ch/f5m/solid) | [F5M/SSH](https://kiota.ch/f5m/ssh)

## Ліцензія

Цей проєкт ліцензовано на умовах MIT — див. файл [LICENSE](LICENSE) для подробиць.

<!-- textlint-enable -->
