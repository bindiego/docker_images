#!/bin/bash -ex

echo "polkadot_build.sh"

[ -d polkadot ] || git clone https://github.com/paritytech/polkadot.git; \
    cd polkadot \
    && git checkout $BRANCH \
    && cargo build --$PROFILE
