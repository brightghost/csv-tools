#!/bin/bash
# print average of result1 (column 3) to stdout
# -sw 2015
#
# bash really doesn't do floating point math 
# (and is a pain even for integer math), so we
# need to use awk or something else for this.
#
# this is probably the point where I would switch
# to a higher-level language if I had any expectation
# of ever needing to touch this script again...

if [ $# -eq 0 ]; then
    echo 'Print average of result 1 column from CSV logs'
	echo 'Usage: '$0' FILE [FILE] ...'
    exit 1
fi

cat $* | \
# remove the header rows
grep -v 'timestamp,name,result1,result2,result3' | \
# add col 3 and divide by num of records
awk -F ',' '{total+=$3}END{print "Average:",total/NR}'