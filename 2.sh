#!/bin/bash
# print lines containing NODATA to stderr
# -sw 2015

if [ $# -eq 0 ]; then
    echo 'Print lines of CSVs containing NODATA to stderr'
	echo 'Usage: '$0' FILE [FILE] ...'
    exit 1
fi

# bash will iterate over the positional params by default if no [in x] specified
for FILE; do

 	egrep NODATA $FILE >&2

done
