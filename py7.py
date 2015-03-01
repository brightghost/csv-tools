import csv
import sys
from tempfile import TemporaryFile
# lets just focus on the python & deal w/ wrapping it in sh later
# notes for next version: 
# 	- use itertools.chain() for concat?
# 	- or can the addition operator work? (+)
# 	- generic column -> list reader


def main():
	debug = True
	if debug:
		print("starting main function")

	mastercsv = TemporaryFile(mode="r+")


def concatInputs (outfile, *args, strip_headers=True):
	'''concat multiple CSV files into one. expects paths as args
	and writes the concat'd file to disk'''
	try:
		if (debug == True):
			print("starting concatInputs")
	except: pass
	mastercsv = open(outfile, 'w+')	
	for path in args:
		with open(path, 'r') as infile:
			if strip_headers == True:
				infile.__next__() # skip the first line, e.g. header
			for line in infile:
				mastercsv.write(line)
	mastercsv.seek(0)
	print(mastercsv.read())
	mastercsv.close()


def meanCol (infile, col):
	'''takes a csv and returns the mean of given column'''
	col_total = 0
	with open(infile, newline='') as csvfile:
		csvreader = csv.reader(csvfile, delimiter=',')
		i = 0 
		for row in csvreader:
			print(row[col])
			try:
				col_total =+ int(row[col])
				i++ # gives us an accurate total excluding invalidated data
			except ValueError:
				print("data \"", row[col], "\" is not a number", file=sys.stderr)
		return col_total/i


def medianCol (infile, col):
	'''takes a csv and returns the median value of given column'''
	with open(infile, newline='') as csvfile:
		csvreader = csv.reader(csvfile, delimiter=',')
		values = []
		for row in csvreader:
			print(row[col])
			try:
				values.append(int(row[col]))
			except ValueError:
				print("data \"", row[col], "\" is not a number", file=sys.stderr)
		sorted_values = sorted(values)
		return median(sorted_values)
		
def median (mylist):
	'''generic median function'''
	if (len(mylist) % 2 == 0):
	 	left_val = mylist[len(mylist) / 2 - 1]
	 	right_val = mylist[len(mylist) / 2]
	 	median_val = (left_val + right_val) / 2
	else:
		median_val = mylist[len(mylist) / 2 - .5]
	return median_val

def modeCol (infile, col):
''' returns mode of given col in csv file. currently uses statistics module
which is new in 3.4. TODO rewrite without this'''
	with open(infile, newline='') as csvfile:
		csvreader = csv.reader(csvfile, delimiter=',')
		values = []
		for row in csvreader:
			try:
				values.append(int(row[col]))
			except ValueError:
				print("data \"", row[col], "\" is not a number", file=sys.stderr)
		sorted_values = sorted(values)
		return statisctics.mode(sorted_values)

# def modeCol (infile, col):
# 	'''takes a csv and returned the most frequent value, 
# 	or None if a tie'''
# 	with open(infile, newline='') as csvfile:
# 		csvreader = csv.reader(csvfile, delimiter=',')
# 		values = []
# 		for row in csvreader:
# 			print(row[col])
# 			try:
# 				values.append(int(row[col]))
# 			except ValueError:
# 				print("data \"", row[col], "\" is not a number", file=sys.stderr)
# 		sorted_values = sorted(values)
# 		value_count = 0
# 		prev_val = None
# 		for val in sorted_values:
# 			if val == prev_val | prev_val == None:
# 				value_count++
# 				prev_val = val






if __name__ == "__main__":
    main()