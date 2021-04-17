#!/bin/bash
pushd `dirname ${0}` > /dev/null || exit 1
source ./env.sh
echo "Validator Balance: `solana --url=localhost balance ${SOLANA_VALIDATOR_PUB_KEY}`"
echo "     Vote Balance: `solana --url=localhost balance ${SOLANA_VOTE_PUB_KEY}`"
popd > /dev/null || exit 1
