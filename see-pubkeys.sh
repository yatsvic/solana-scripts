#!/bin/bash

pushd `dirname ${0}` > /dev/null || exit 1
source env.sh
echo "Validator: `solana address -k ${SOLANA_VALIDATOR_KEY_PATH}`"
echo "     Vote: `solana address -k ${SOLANA_VOTE_KEY_PATH}`"
popd > /dev/null || exit 1

