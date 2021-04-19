#!/bin/bash
pushd `dirname ${0}` > /dev/null || exit 1
source ./env.sh
TABLE=`solana --url=localhost block-production` 
echo "${TABLE}" | head -n 4
echo "${TABLE}" | grep ${SOLANA_VALIDATOR_PUB_KEY}
echo "${TABLE}" | tail -n 3 
popd > /dev/null || exit 1

