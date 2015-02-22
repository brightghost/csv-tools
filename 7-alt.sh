#!/usr/local/bin/python3

import sys
import csv
from tempfile import TemporaryFile

mastercsv = TemporaryFile(mode="r+")

for filename in sys.argv[1:]:
	with open(filename, 'r') as csvfile:
		csvfile.__next__() # skip the first line, e.g. header
		for line in csvfile:
			mastercsv.write(line)

print(mastercsv.read())

mastercsv.close()