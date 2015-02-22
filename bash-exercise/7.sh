#!/bin/bash
# mean, median and mode
# -sw 2015

if [ $# -eq 0 ]; then
    echo 'Print mean, median, mode of results for each machine name'
	echo 'Usage: '$0' FILE [FILE] ...'
    exit 1
fi

# dump the sorted list of names into a var to use in assembling the final list
NAMES=$(
# concat input; we need to sort also for uniq to work
sort -d --field-separator=, --key=2,2 $* | \
# remove the header rows
grep -v 'timestamp,name,result1,result2,result3' | \
# pull just name column
cut -d ',' -f 2 | \
# 
uniq
)

for NAME in $NAMES; do
	echo $NAME
	# TODO should handle these tmp files properly if we expect this to be at all portable
	# mixing in the script name at least gives us some basic protection against clobbering anything
	TMPCSV="$0.tmp.csv"
	# clear all the tmp files before use in case the script had an unclean exit previously
	echo "" > $TMPCSV
	grep -h $NAME $* > $TMPCSV
	# concat all results entries
	# `cut` can take multiple fields in one argument, but then we have to
	# deal with wonky formatting
	RESULTSCSV="$0.results.csv"
	echo "" > $RESULTSCSV
	RESULTFIELDS="3 4 5"
	for FIELD in $RESULTFIELDS; do
		cat $0.tmp.csv | cut -f $FIELD -d ',' | grep -v 'NODATA' >> $RESULTSCSV
	done
	rm $TMPCSV


	# average of results data
	cat $RESULTSCSV | awk -F ',' '{total+=$1}END{print "   Mean:",total/NR}'
	
	# median of results data
	# ...this is just some boilerplate pulled off stackoverflow.
	# I would really avoid doing this with a bash script if given the choice...
	cat $RESULTSCSV | sort -g | awk ' { a[i++]=$1; } END { x=int((i+1)/2); if (x < (i+1)/2) print "   Median:",(a[x-1]+a[x])/2; else print "   Median:",a[x-1]; }'
	
	# mode of results data ... pretty ugly
	FREQLIST="$0.freqlist.txt"
	echo "" > $FREQLIST
	cat $RESULTSCSV | sort -g | uniq -c | sed 's/^ *//g' | sort -rg --field-separator=" " --key=1,1 > $FREQLIST
	FREQCOUNT1=$(sed -ne 1p $FREQLIST | cut -f 1 -d ' ')
	FREQVAL=$(sed -ne 1p $FREQLIST | cut -f 2 -d ' ')
	FREQCOUNT2=$(sed -ne 2p $FREQLIST | cut -f 1 -d ' ')
	if [[ $FREQCOUNT1 = $FREQCOUNT2 ]]; 
	then
		echo "   Mode: No Mode"
	else
		echo "   Mode: "$FREQVAL
	fi
	rm $FREQLIST
	rm $RESULTSCSV
done
