#!/bin/bash
# sort names in reverse alphabetical order
# -sw 2015

if [ $# -eq 0 ]; then
    echo 'Sort CSV logs by name, Z-A'
	echo 'Usage: '$0' FILE [FILE] ...'
    exit 1
fi
# only tested with gnu sort but bsd/etc should behave the same..

sort -dr --field-separator=, --key=2,2 $*