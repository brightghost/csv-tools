#!/bin/bash
# sort by date field
# -sw 2015

if [ $# -eq 0 ]; then
    echo 'Sort CSV logs by date field'
	echo 'Usage: '$0' FILE [FILE] ...'
    exit 1
fi
# only tested with gnu sort but bsd/etc should behave the same..

# the second key ensures the part of the timestamp after the 
# 'T' separator is followed as well
sort -n --field-separator=, --key=1,1.8 --key=1.10,1 $*