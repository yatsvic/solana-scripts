#!/bin/bash
pushd $(dirname ${0}) >/dev/null || exit 1
source ./env.sh
mkdir -p ${SOLANA_SNAPSHOTS_DIR}/remote
export RPC_URL=$(solana config get | grep "RPC URL" | awk '{ print $3 }')
python3 ../solana-snapshot-finder/snapshot-finder.py \
  --snapshot_path ${SOLANA_SNAPSHOTS_DIR}/remote \
  --rpc_address ${RPC_URL} \
  --max_latency 300 \
  --min_download_speed 2 \
  --max_snapshot_age 10000 \
  --with_private_rpc
popd > /dev/null || exit 1
