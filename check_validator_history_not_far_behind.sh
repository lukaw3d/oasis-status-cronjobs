#!/bin/bash
set -euo pipefail
set -x

epoch_url=${1:-"https://nexus.stg.oasis.io/v1/consensus/epochs?limit=1"}
validator_history_url=${2:-"https://nexus.stg.oasis.io/v1/consensus/validators/oasis1qq3xrq0urs8qcffhvmhfhz4p0mu7ewc8rscnlwxe/history?limit=1"}
latest_epoch=$(curl "$epoch_url" -sS --fail | jq .epochs[0].id -r)
history_epoch=$(curl "$validator_history_url" -sS --fail | jq .history[0].epoch -r)
echo "is $history_epoch more than 12 hours behind $latest_epoch?"

[ $history_epoch -ge $(( $latest_epoch - 12 )) ]
