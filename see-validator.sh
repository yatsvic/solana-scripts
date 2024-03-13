#!/bin/bash
pushd $(dirname ${0}) > /dev/null || exit 1
source ./env.sh
TABLE=$(solana --url=localhost validators)
echo "${TABLE}" | head -n 1
echo "${TABLE}" | grep ${SOLANA_VALIDATOR_PUB_KEY}
echo "${TABLE}" | tail -n 11
popd > /dev/null || exit 1

