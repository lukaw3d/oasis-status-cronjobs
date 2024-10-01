#!/bin/bash
set -euo pipefail
set -x

status_url=${1:-"https://nexus.stg.oasis.io/v1/"}
epoch_url=${2:-"https://nexus.stg.oasis.io/v1/consensus/epochs?limit=1"}
latest_block=$(curl "$status_url" -sS --fail | jq .latest_block -r)
epoch_block=$(curl "$epoch_url" -sS --fail | jq .epochs[0].start_height -r)
echo "is $epoch_block more than 12 hours behind $latest_block?"

[ $epoch_block -ge $(( $latest_block - 12*60*60/6 )) ]
