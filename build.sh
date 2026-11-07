#!/bin/sh

set -xe

make -C "$1" BATCH=yes \
    install-missing-packages

make -C "$1" BATCH=yes \
    USE_PACKAGE_DEPENDS_ONLY=yes \
    MAKE_JOBS_NUMBER="$(sysctl -n hw.ncpu)" \
    package && \
    mkdir -p /tmp/pkg-out && \
    cp -a "$1/work/pkg/"*.pkg /tmp/pkg-out
