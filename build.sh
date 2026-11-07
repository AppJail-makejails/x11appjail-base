#!/bin/sh

set -e

make -C $1 BATCH=yes MAKE_JOBS_NUMBER=$(sysctl -n hw.ncpu) package && \
    mkdir -p /tmp/pkg-out && \
    cp -a $1/work/pkg/*.pkg /tmp/pkg-out
