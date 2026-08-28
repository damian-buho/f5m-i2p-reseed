# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

ARG B19_GO_BASE_IMAGE=registry.invalid/b19/go:latest
ARG B19_UBUNTU_BASE_IMAGE=registry.invalid/b19/ubuntu/resolute:latest
ARG B19_UBUNTU_SERIES=resolute

FROM ${B19_GO_BASE_IMAGE} AS f5m-go-builder

ARG B19_COLOR
ARG B19_FETCH_DOCKER_CACHE
ARG B19_FETCH_LOCAL_CACHE
ARG B19_OFFGRID_MODE
ARG B19_VERBOSITY
ARG LANG=""
ARG M6E_AI=N
ARG M6E_APT_CACHE_HOST=""
ARG M6E_APT_CACHE_PORT=""
ARG M6E_BUILD_DEBUG=""
ARG M6E_NEAR_CACHE_HOST=""
ARG M6E_NAMESPACE
ARG M6E_PROJECT
ARG TARGETARCH

USER 0

WORKDIR ${B19_HOME}

COPY --chown=${B19_UID}:${B19_GID} .container/compile-go/ /

RUN --mount=type=bind,from=fetch,source=.,target=/fetch                                           \
    --mount=type=cache,target=${B19_DOWNLOAD_PATH},sharing=shared                                 \
    --mount=type=cache,target=${GOCACHE},sharing=locked                                           \
    --mount=type=cache,target=${GOMODCACHE},sharing=locked                                        \
    --mount=type=cache,id=apt-cache-${B19_UBUNTU_SERIES}-${TARGETARCH},target=/var/cache/apt,sharing=shared     \
    --mount=type=cache,id=apt-lists-${B19_UBUNTU_SERIES}-${TARGETARCH},target=/var/lib/apt,sharing=shared       \
    --mount=type=tmpfs,target=${B19_TEMP_PATH}                                                    \
    build-stage compile-go

# hadolint DL3002
# hadolint ignore=DL3066 # B19_UID comes from the root
USER ${B19_UID}

FROM ${B19_UBUNTU_BASE_IMAGE} AS f5m-i2p-reseed

ARG B19_COLOR
ARG B19_FETCH_DOCKER_CACHE
ARG B19_FETCH_LOCAL_CACHE
ARG B19_OFFGRID_MODE
ARG B19_VERBOSITY
ARG LANG=""
ARG M6E_AI=N
ARG M6E_APT_CACHE_HOST=""
ARG M6E_APT_CACHE_PORT=""
ARG M6E_BUILD_DEBUG=""
ARG M6E_NEAR_CACHE_HOST=""
ARG M6E_NAMESPACE
ARG M6E_PROJECT
ARG M6E_VERSION
ARG TARGETARCH

ENV DEBUG_I2P="warn"                                        \
    WARNFAIL_I2P=""                                         \
    F5M_I2P_RESEED_SIGNER=""                                \
    F5M_I2P_RESEED_NETDB="${B19_HOME}/.i2p/netDb"           \
    F5M_I2P_RESEED_KEYS_DIR="${XDG_DATA_HOME}/keys"         \
    F5M_I2P_RESEED_IP="0.0.0.0"                             \
    F5M_I2P_RESEED_PORT="8080"                              \
    F5M_I2P_RESEED_TRUST_PROXY="true"                       \
    F5M_I2P_RESEED_TLS_HOST=""                              \
    F5M_I2P_RESEED_PREFIX=""                                \
    F5M_I2P_RESEED_NUM_RI="61"                              \
    F5M_I2P_RESEED_NUM_SU3="50"                             \
    # 1h, not upstream's 90h: the initial rebuild fails while the netDb is
    # still filling (sibling router booting) and upstream retries only on
    # this ticker — 90h would delay the first usable bundle by days.
    F5M_I2P_RESEED_INTERVAL="1h"                            \
    F5M_I2P_RESEED_ROUTER_INFO_AGE="72h"                    \
    F5M_I2P_RESEED_RATELIMIT="4"                            \
    F5M_I2P_RESEED_RATELIMITWEB="40"                        \
    F5M_I2P_RESEED_BLACKLIST=""                             \
    F5M_I2P_RESEED_STATS=""                                 \
    F5M_I2P_RESEED_ARGS=""

USER 0

WORKDIR ${B19_HOME}

COPY    --chown=${B19_UID}:${B19_GID}                           .container/base/    /
COPY    --chown=${B19_UID}:${B19_GID} --from=f5m-go-builder     /export             /

RUN     --mount=type=cache,id=apt-cache-${B19_UBUNTU_SERIES}-${TARGETARCH},target=/var/cache/apt,sharing=shared     \
    --mount=type=cache,id=apt-lists-${B19_UBUNTU_SERIES}-${TARGETARCH},target=/var/lib/apt,sharing=shared       \
    --mount=type=bind,from=fetch,source=.,target=/fetch                                           \
    --mount=type=cache,target=${B19_DOWNLOAD_PATH},sharing=shared                                 \
    --mount=type=tmpfs,target=${B19_TEMP_PATH}                                                    \
    build-stage base

# hadolint ignore=DL3066 # B19_UID comes from the root
USER ${B19_UID}

COPY --chown=${B19_UID}:${B19_GID} .container/user/ /

RUN --mount=type=bind,from=fetch,source=.,target=/fetch                                             \
    --mount=type=cache,target=${B19_DOWNLOAD_PATH},sharing=shared,uid=${B19_UID},gid=${B19_GID}     \
    --mount=type=tmpfs,target=${B19_TEMP_PATH}                                                      \
    build-stage user

# ENTRYPOINT ["entrypoint.d"] is inherited
# HEALTHCHECK CMD ["healthcheck.d"] is inherited
# Don't use CMD ["sleep", "infinity"] here

# Enable Traefik Docker Discovery
LABEL traefik.enable=true
LABEL traefik.http.routers.i2p-reseed.rule="Host(`i2p-reseed.docker.localhost`)"
LABEL traefik.http.routers.i2p-reseed.entrypoints=web,websecure
LABEL traefik.http.routers.i2p-reseed.middlewares=redirect-to-https@file
LABEL traefik.http.services.i2p-reseed.loadbalancer.server.port=${F5M_I2P_RESEED_PORT}
