#!/usr/bin/python
import os
import sys
import string

def usage():
	print('** usage: filename -l [matrix/vector length] -b [begin] -e [end] -s [step]')

if __name__ == '__main__':

	begin = 0
	end = 0;
	step = 0;
	netlen = 15;
#==========================================================
# parse command line
	for ind in range(1, len(sys.argv)):
		if sys.argv[ind][0] == '-':
			if sys.argv[ind][1] == 'b':
				ind = ind + 1
				begin = string.atoi(sys.argv[ind])
			elif sys.argv[ind][1] == 'e':
				ind = ind + 1
				end = string.atoi(sys.argv[ind])
			elif sys.argv[ind][1] == 's':
				ind = ind + 1
				step = string.atoi(sys.argv[ind])
			elif sys.argv[ind][1] == 'l':
				ind = ind + 1
				netlen = string.atoi(sys.argv[ind])
	if begin == 0 or end == 0 or step == 0:
		usage()
		sys.exit()
#===========================================================
# call executable file to generate .sp file
# call hspice to simulate circuit netlist, and then output .lis files

	isPathExist = os.path.exists('lisfiles/')
	if not isPathExist:
		os.makedirs('lisfiles/')
		print('** succeed to make directory lisfiles/ ')
	
	isPathExist = os.path.exists('voltagedata/')
	if not isPathExist:
		os.makedirs('voltagedata/')
		print('** succeed to make directory voltagedata/')
	
	isPathExist = os.path.exists('spfile/')
	if not isPathExist:
		os.makedirs('spfile/')
		print('** succeed to make directory spfile/')
	for i in range(begin, end, step):
		os.system(r'./gennetlist -r %d -s %d'%(i, netlen))
		print('==========================')
		print('resistor r0 value = %dk'%(i))
		os.system(r'mv resnet.sp spfile/resnet_' + str(netlen) + '_' + str(i) + '.sp')
	#	os.system(r'hspice -i spfile/resnet_'+str(netlen)+'_' + str(i) + \
	#		'.sp -o lisfiles/resnet_'+str(netlen)+'_'+ str(i) + '.lis;\n')
		os.system(r'aps -outdir lisfiles/ spfile/resnet_'+str(netlen)+'_'+str(i)+'.sp')

#===========================================================
# process .lis files, extract data we want.
# generate .txt files, which just contain useful data existing as a column in the files.
	for fileid in range(begin, end, step):
		
		lispath1 = 'lisfiles/' + 'resnet_'+str(netlen)+'_' + str(fileid) + '.lisn.lis'
		lispath2 = 'lisfiles/' + 'resnet_'+str(netlen)+'_' + str(fileid) + '.lis'
		islispath = os.path.exists(lispath1)
		lispath = lispath1
		if not islispath:
			lispath = lispath2
		
		fp  = open(lispath, "r+")
		print('\n** extra node voltage results')
	
		resultbeginline = 'dc transfer curves'
		array = list()
		while 1:
			strline = fp.readline()
			if not strline:
				break
			if strline.find('volt    voltage') >= 0:
				segment = list()
				switch = 0
				strline = fp.readline()
				strline = fp.readline()
				strline = strline.strip()
				print("%s"%(strline))
				for i in range(7, len(strline)):
					char = strline[i]
					if switch == 0 and char != ' ':
						segment.append(i)
						switch = 1
					elif switch == 1 and char == ' ':
						segment.append(i)
						switch = 0
				for i in range(0, len(segment) - 1, 2):
					strdata = strline[segment[i] : segment[i + 1]]
					array.append(strdata)
				strdata = strline[segment[len(segment) - 1] : len(strline)]
				array.append(strdata)
	
		fp.close()
	
		fp = open("voltagedata/" + "voltage_"+str(netlen)+'_' + str(fileid)  + ".txt", "w+")
		for i in range(0, len(array)):
			fp.write("%s\n"%(array[i]))
		fp.close()

#============================================================
