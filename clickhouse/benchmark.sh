#!/bin/bash


clickhouse_cmd="clickhouse client -h 11.102.246.118 --port 9600 --user default --password NTliOGQ3YjRiY2MyNTc4"

# $clickhouse_cmd < create.sql

#wget --no-verbose --continue 'https://datasets.clickhouse.com/hits_compatible/hits.tsv.gz'
#gzip -d hits.tsv.gz

$clickhouse_cmd --time --query "INSERT INTO hits FORMAT TSV" < hits.tsv

# Run the queries

./run.sh

$clickhouse_cmd --query "SELECT total_bytes FROM system.tables WHERE name = 'hits' AND database = 'default'"
