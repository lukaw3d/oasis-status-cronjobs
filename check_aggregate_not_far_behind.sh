status_url=$1
aggregate_url=$2
latest_time_str=$(curl "$status_url" --fail | jq .latest_block_time -r)
latest_time=$(date -d $latest_time_str +%s)
aggregate_stats_time_str=$(curl "$aggregate_url" --fail | jq .windows[0].window_end -r)
aggregate_stats_time=$(date -d $aggregate_stats_time_str +%s)
echo "is $aggregate_stats_time_str more than 12 hours behind $latest_time_str?"
[ $aggregate_stats_time -ge $(( $latest_time - 12*60*60 )) ]
