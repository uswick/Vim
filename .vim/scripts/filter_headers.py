#!/usr/bin/python

'''
./filter_header_dirs
    -f : directories with file types to consider (default .h files)
    -e : exclude dire with this pattern - A comma seperated list (no spaces between) of strings
    -h : this menu
'''
import time
import getopt
import os
import re
import sys
from os import system, name 
import enum
import traceback
from subprocess import Popen, PIPE
from sys import platform
from datetime import datetime

header_only_folders={}
header_only_folders_after_ex={}

def exit_with_usage():
    print(globals()['__doc__'])
    os._exit(1)


if __name__ == '__main__':
    path_filters = ["build/"]
    path_filters_inc = []
    file_filters = ["h"]
    try:
        optlist, args = getopt.getopt(sys.argv[1:], 'h?f:e:i:', ['help','h','?'])
    except Exception as e:
        print(str(e))
        exit_with_usage()

    options = dict(optlist)
    if len(args) > 1:
        exit_with_usage()
        
    if [elem for elem in options if elem in ['-h','--h','-?','--?','--help']]:
        print("Help:")
        exit_with_usage()

    try:
        if '-f' in options:
            headers = options['-f']
            # print str(headers.split(","))
            hd_ar = headers.split(",")
            for h in hd_ar:
                if h.strip() not in file_filters and h.strip() != "":
                    file_filters.append(h.strip())
        
        if '-e' in options:
            excludes = options['-e']
            # print str(excludes.split(","))
            ex_ar = excludes.split(",")
            for e in ex_ar:
                if e.strip() not in path_filters and e.strip() != "":
                    path_filters.append(e.strip())

        if '-i' in options:
            includes = options['-i']
            # print str(includes.split(","))
            inc_ar = includes.split(",")
            for i in inc_ar:
                if i.strip() not in path_filters_inc and i.strip() != "":
                    path_filters_inc.append(i.strip())
    except Exception as e:
        pass
#
                
    # print "path_filters =", str(path_filters)
    # print "file_filters =", str(file_filters)

    for ftype in file_filters:
        pipe = Popen("find . -type f -name '*.{}' ".format(ftype) , stdout=PIPE, shell=True)
        output = pipe.communicate()[0]
        for line in output.splitlines():
            # print "l=", line.split()
            l = line.strip()
            path = os.path.abspath(os.path.join(l, os.pardir))
            header_only_folders[path]=1

    # print str(header_only_folders.keys())    
    i = 0
    for k in header_only_folders.keys():
        filter_this_path=False
        for fi in path_filters:
            if fi.strip() in k:
                filter_this_path=True
                break

        if filter_this_path == False:
            # print "header folder[%d]=" % i , k
            # print "-I{}".format(k.strip())
            header_only_folders_after_ex[k]=1
            i = i + 1
        pass
    
    for k in header_only_folders_after_ex.keys():
        filter_this_path=True
        for fi in path_filters_inc:
            if fi.strip() in k:
                filter_this_path=False
                break

        if filter_this_path == False:
            # print "header folder[%d]=" % i , k
            print "-I{}".format(k.strip())
            i = i + 1
        pass
    # print "filters# = ", i
