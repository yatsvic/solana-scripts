#!/bin/bash
pushd $(dirname ${0}) >/dev/null || exit 1
source ./env.sh
solana catchup ${SOLANA_VALIDATOR_KEY_PATH} --our-localhost --follow --log
popd > /dev/null || exit 1

