#!/usr/bin/python
import time
import getopt
import os
import re
import sys
from os import system, name 
import enum
import traceback
from subprocess import Popen, PIPE

def wait():
    raw_input("Press Enter to continue...")

def wait_yes(question):
    while "the answer is invalid":
        reply = str(raw_input(question+' (y/n): ')).lower().strip()
        if reply[:1] == 'y':
            return True
        if reply[:1] == 'n':
            return False
        else: #default Yes
            return True

if __name__ == '__main__':

    # "vim -c "tabedit tmp/stubs.c" -c "diffsplit /opt/install/repos01/mytree-3/bora/vmcore/bootstrap/vmm/stubs.c"
    desc_file='p4diff_files'
    vim_cmd="vim -c '"
    vimdiff_cmd=" tabedit {} | vert diffsplit {} | "
    vim_cmd_end=" tabedit | vert diffsplit'"

    _bora_working_dir = os.getcwd()
    tmp_dir = "{}/tmp".format(_bora_working_dir)
    print "[DEBUG] Bora working dir: ", _bora_working_dir

    if(os.path.isdir(_bora_working_dir) == False):
        os.mkdir(tmp_dir)
        print "[DEBUG] Created tmp dir: ", tmp_dir

    #clean temp dir
    clean_cmd="rm -rf {}/*".format(tmp_dir)
    print "[DEBUG] cleaning up, ", clean_cmd, " ..."
    wait()
    os.system(clean_cmd)

    p4_cmd="p4 print {} > {}"

    if os.path.isfile(desc_file) == True:
        with open(desc_file, "r") as desc_fd:
            for line in desc_fd:
                # only read first line
                desc = line.strip()
                while(desc[0] == '=' or desc[-1] == '='):
                    desc = desc.strip('=')
                desc = desc.strip()
                if(desc[0:2] == "//"):
                    # print desc
                    splits=re.split(' - ', desc)
                    p4file=splits[0].strip()
                    wdirfile=splits[1].strip()
                    p4file_name=os.path.basename(p4file).replace('#','_')
                    p4file_path="{}/{}".format(tmp_dir, p4file_name)
                    # print "[DEBUG] creating tmp file, ", p4file_path
                    # wait()
                    if wait_yes("Add {} to vmdiff? ".format(wdirfile)):
                        os.system(p4_cmd.format(p4file, p4file_path))
                        vim_cmd += vimdiff_cmd.format(p4file_path, wdirfile)

        vim_cmd += vim_cmd_end

        print "[DEBUG] p4vimdiff.py Init complete..."
        print "[DEBUG] Key bindings: ]+c => next hunk, [+c => prev hunk"
        wait()
        if wait_yes("Run vmdiff? "):
            os.system(vim_cmd)
        else:
            print "Run command: ", vim_cmd
    else:
        print "{} not found!".format(desc_file)

