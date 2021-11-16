#!/bin/bash
pushd `dirname ${0}` > /dev/null || exit 1
source ./env.sh
rm -rf ${SOLANA_LEDGER_DIR}
rm -rf ${SOLANA_ACCOUNTS_DIR}
popd > /dev/null || exit 1

