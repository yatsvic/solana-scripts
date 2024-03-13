#!/bin/bash
pushd $(dirname ${0}) > /dev/null || exit 1
source ./env.sh
rm -rf ${SOLANA_LEDGER_DIR}
rm -rf ${SOLANA_ACCOUNTS_DIR}
rm -rf ${SOLANA_ACCOUNTS_INDEX_PATH}
rm -rf ${SOLANA_ACCOUNTS_HASH_CACHE_PATH}
popd > /dev/null || exit 1
