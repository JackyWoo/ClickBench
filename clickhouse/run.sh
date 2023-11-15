#!/bin/bash

clickhouse_cmd="clickhouse client -h 11.102.246.118 --port 9600 --user default --password NTliOGQ3YjRiY2MyNTc4"
#clickhouse_cmd="clickhouse client -h localhost --port 3000 --database woo"

OPTIMIZE=ON

TRIES=3
QUERY_NUM=2
#set -ex
cat queries.sql | grep -v '#' | while read query; do
    #[ -z "$FQDN" ] && sync
    #[ -z "$FQDN" ] && echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null

    if [[ $OPTIMIZE == 'ON' ]]; then
	query=$(echo "$query" | sed 's/.$//')
	query="$query SETTINGS allow_experimental_query_coordination = 1,cost_merge_agg_uniq_calculation_weight=1.0;"
	#echo $query
    fi
    #echo -n "["
    OUT_LINE=${QUERY_NUM}
    for i in $(seq 1 $TRIES); do
        RES=$($clickhouse_cmd --time --format=Null --query="$query" 2>&1 ||:)
        #[[ "$?" == "0" ]] && echo -n "${RES}" || echo -n "null"
        #[[ "$i" != $TRIES ]] && echo -n ", "
	
	OUT_LINE="$OUT_LINE,$RES"
        #echo "${QUERY_NUM},${i},${RES}" >> result.csv
	
    done
    echo "$OUT_LINE" >> result.csv
    echo "$OUT_LINE"
    #echo "],"

    QUERY_NUM=$((QUERY_NUM + 1))
done
