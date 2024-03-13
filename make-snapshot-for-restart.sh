#!/bin/bash

if [ $# -eq 0 ]; then
 echo "no slot provided"
 exit 1
fi

export SLOT=${1}
pushd $(dirname ${0}) > /dev/null || exit 1
source ./env.sh
solana-ledger-tool \
  --ledger ${SOLANA_LEDGER_DIR} \
  --snapshot-archive-path ${SOLANA_SNAPSHOTS_DIR} \
  create-snapshot ${SLOT} ${SOLANA_SNAPSHOTS_DIR} \
  --hard-fork ${SLOT} \
#  --destake-vote-account ***

popd > /dev/null || exit 1
