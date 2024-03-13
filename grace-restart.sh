#!/bin/bash

pushd $(dirname ${0}) > /dev/null || exit 1
source ./env.sh
solana-validator \
    --ledger ${SOLANA_LEDGER_DIR} \
    exit \
    --max-delinquent-stake 5 \
    --min-idle-time 60
popd > /dev/null || exit 1
