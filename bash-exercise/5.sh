#!/bin/bash
# count and display occurences of names, sort by number of occurences
# -sw 2015

if [ $# -eq 0 ]; then
    echo 'Count and sort CSV logs by occurences of names'
	echo 'Usage: '$0' FILE [FILE] ...'
    exit 1
fi

# dump the sorted list of names into a var to use in assembling the final list;
# prints sorted names and occurences along the way
NAMES=$(
# first let's concat inputs
# we need to sort also for uniq to work
sort -dr --field-separator=, --key=2,2 $* | \
# remove the header rows
grep -v 'timestamp,name,result1,result2,result3' | \
# pull only name column
cut -d ',' -f 2 | \
# list number of occurences
uniq -c | \
# strip leading whitespace otherwise 'sort' interprets it as empty fields
sed 's/^ *//g' | \
# -g: 'general' sort handles numbers w/o leading zeros correctly
sort -rg --field-separator=" " --key=1,1 | \
# tee to redirect to console plus do further processing; avoids having to use a tmpfile
# `tee /dev/stdout` causes weird permission errors even tho bash is supposed to rewrite it..
# benefit however is this 'informational' data only goes to term, and the 
# rewritten table by itself can be piped
tee /dev/tty | \
# pull only sorted names for use in assembling final table
cut -d " " -f 2
)

# finally, use sorted name list to print from input
for NAME in $NAMES; do
	grep -h $NAME $*
done