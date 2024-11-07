#!/bin/bash
pushd `dirname ${0}` >/dev/null || exit 1
source ./env.sh
agave-validator --ledger ${SOLANA_LEDGER_DIR} monitor
popd > /dev/null || exit 1

