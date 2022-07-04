#!/bin/bash

pushd `dirname ${0}` > /dev/null || exit 1
source ./env.sh
solana-validator \
	--ledger ${SOLANA_LEDGER_DIR} \
	wait-for-restart-window \
	--max-delinquent-stake 10 \
        --min-idle-time 10
popd > /dev/null || exit 1

