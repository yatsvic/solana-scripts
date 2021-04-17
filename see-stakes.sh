#!/bin/bash
pushd `dirname ${0}` > /dev/null || exit 1
source ./env.sh
solana --url=localhost stakes -ut ${SOLANA_VOTE_PUB_KEY}
popd > /dev/null || exit 1
