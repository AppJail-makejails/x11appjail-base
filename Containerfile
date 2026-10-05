ARG FREEBSD_RELEASE

FROM ghcr.io/appjail-makejails/base:${FREEBSD_RELEASE}

ARG NO_PKGCLEAN
ARG IS_X11

LABEL org.opencontainers.image.title="x11appjail base image" \
    org.opencontainers.image.description="x11appjail base image" \
    org.opencontainers.image.source="https://github.com/AppJail-makejails/x11appjail-base" \
    org.opencontainers.image.url="https://github.com/DtxdF/x11appjail" \
    org.opencontainers.image.vendor="DtxdF" \
    org.opencontainers.image.authors="Jesús Daniel Colmenares Oviedo <dtxdf@disroot.org>"

RUN set -xe; \
    \
    umask 0022; \
    \
    packages=; \
    \
    if [ -n "${IS_X11}" ]; then \
        packages="xauth xrandr ratpoison xorg-fonts mesa-dri mesa-libs setxkbmap dunst virtualgl"; \
    fi; \
    \
    pkg update; \
    pkg install FreeBSD-set-base-jail xdg-utils ${packages}; \
    \
    if [ -z "${NO_PKGCLEAN}" ]; then \
        pkg clean -a; \
        rm -rf /var/cache/pkg/*; \
    fi; \
    rm -rf /var/db/pkg/repos/*; \
    \
# Prevent permission issues when a package is installed there.
    mkdir -p /usr/local/sbin; \
    chmod 755 /usr/local/sbin
