#!/bin/bash
set -euo pipefail
set -x

status_url=${1:-"https://nexus.stg.oasis.io/v1/"}
aggregate_url=${2:-"https://nexus.stg.oasis.io/v1/consensus/stats/active_accounts?window_step_seconds=300&limit=1"}
latest_time_str=$(curl "$status_url" -sS --fail | jq .latest_block_time -r)
aggregate_stats_time_str=$(curl "$aggregate_url" -sS --fail | jq .windows[0].window_end -r)
echo "is $aggregate_stats_time_str more than 12 hours behind $latest_time_str?"

latest_time=$(date -d $latest_time_str +%s)
aggregate_stats_time=$(date -d $aggregate_stats_time_str +%s)
[ $aggregate_stats_time -ge $(( $latest_time - 12*60*60 )) ]
