#!/bin/bash -ex

echo "phala_build.sh"

[ -d phala-blockchain ] || git clone https://github.com/Tenet-X/phala-blockchain.git; \
    cd phala-blockchain \
    && git checkout $BRANCH \
    && git submodule update --recursive \
    && cargo +$NIGHTLY build --$PROFILE
