#!/bin/bash

pushd `dirname ${0}` > /dev/null || exit 1
source ./env.sh
solana-validator --ledger ${SOLANA_LEDGER_DIR} wait-for-restart-window
popd > /dev/null || exit 1

