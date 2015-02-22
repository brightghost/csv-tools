#!/bin/bash
# concat csv's
# -sw 2015

if [ $# -eq 0 ]; then
    echo 'Concatenate CSV files; outputs merged.csv'
	echo 'Usage: '$0' FILE [FILE] ...'
    exit 1
fi

cat $* > merged.csv
