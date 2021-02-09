#!/usr/bin/python
#type in full path and names of files to average here
import os
#workdir = os.getcwd() #change this to where you want to start from
#eg.workdir = '/data/pegasus/jmeltzer/N400P600_study/Auditory/epoch_data/pilot'
workdir = '/home/student12/data/proc'
os.chdir(workdir)

hcfilenames = [
	'last_word_run_01.ds/last_word_run_01.hc',
	'last_word_run_02.ds/last_word_run_02.hc',
	'last_word_run_03.ds/last_word_run_03.hc',
	'last_word_run_04.ds/last_word_run_04.hc',
	'last_word_run_05.ds/last_word_run_05.hc'
]

#type name of dataset to be modified
datasetname = 'last_word_grand.ds'

commandfilename = 'changeheadposcommand_last.txt'
posfilename = 'headpos_measurements_last.txt'

##################################

import re
posnumber = re.compile(r'([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)$', re.VERBOSE)
#regular expression to find a floating point number at end of line

def mean(numberList):
    if len(numberList) == 0:
        return float('nan')

    floatNums = [float(x) for x in numberList]
    return sum(floatNums) / len(numberList)


nax = []
nay = []
naz = []
lex = []
ley = []
lez = []
rex = []
rey = []
rez = []

for infilename in hcfilenames:
#infilename = '7324_AEF_20111130_02.hc'
	infile = open(infilename,'r').readlines()
	numstr = re.search(posnumber,infile[13]).group(0)
	nax.append(numstr)
	numstr = re.search(posnumber,infile[14]).group(0)
	nay.append(numstr)
	numstr = re.search(posnumber,infile[15]).group(0)
	naz.append(numstr)
	numstr = re.search(posnumber,infile[17]).group(0)
	lex.append(numstr)
	numstr = re.search(posnumber,infile[18]).group(0)
	ley.append(numstr)
	numstr = re.search(posnumber,infile[19]).group(0)
	lez.append(numstr)
	numstr = re.search(posnumber,infile[21]).group(0)
	rex.append(numstr)
	numstr = re.search(posnumber,infile[22]).group(0)
	rey.append(numstr)
	numstr = re.search(posnumber,infile[23]).group(0)
	rez.append(numstr)

anax = round(mean(nax),4)
anay = round(mean(nay),4)
anaz = round(mean(naz),4)
alex = round(mean(lex),4)
aley = round(mean(ley),4)
alez = round(mean(lez),4)
arex = round(mean(rex),4)
arey = round(mean(rey),4)
arez = round(mean(rez),4)

outstr = ('changeHeadPos -na ' + str(anax) + ' ' + str(anay) + ' ' + str(anaz)
	+ ' -le ' + str(alex) + ' ' + str(aley) + ' ' + str(alez)
	+ ' -re ' + str(arex) + ' ' + str(arey) + ' ' + str(arez) + ' ' + datasetname + '\n')

outfile = open(commandfilename,'w')
outfile.write(outstr)
outfile.close()

headerline = 'nax\tnay\tnaz\tlex\tley\tlez\trex\trey\trez\n'
outfile = open(posfilename,'w')
outfile.write(headerline)
for run in range(0,len(nax)):
	outstr = str(nax[run]) + '\t' + str(nay[run]) + '\t' + str(naz[run]) + '\t' + \
		str(lex[run]) + '\t' + str(ley[run]) + '\t' + str(lez[run]) + '\t' + \
		str(rex[run]) + '\t' + str(rey[run]) + '\t' + str(rez[run]) + '\n'
	outfile.write(outstr)

outfile.close()
