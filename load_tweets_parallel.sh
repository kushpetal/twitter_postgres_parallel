#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time echo "$files" | time parallel sh load_denormalized.sh

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time echo "$files" | time parallel python3 -u load_tweets.py --db=postgresql://postgres:pass@localhost:1235/ --inputs

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time echo "$files" | time parallel python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:1236/ --inputs
