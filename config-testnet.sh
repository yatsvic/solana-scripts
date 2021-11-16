#!/bin/bash

pushd `dirname ${0}` > /dev/null || exit 1
source ./env.sh
solana config set --url https://api.testnet.solana.com
solana config set --keypair ${SOLANA_VALIDATOR_KEY_PATH}
popd > /dev/null || exit 1

