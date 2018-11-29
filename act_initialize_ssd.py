#!/usr/bin/python
####
####
# Act prepare SSD to run act benchmark aerospike latency verification tool.
####
import cmd
import os
import sys
import argparse
import subprocess
from subprocess import call


NVME='nvme0n'
FACTOR=1000

def get_device_name():
    cmd = "lsblk"
    device_list = []
    nvmelist = []
    try:
        templist = subprocess.check_output(cmd.split()).splitlines()
    except Exception, i:
        print '\nException: ', i
        return  NULL
    for _temp in templist:
        print _temp
        if NVME in _temp:
           nvmelist.append(_temp.split()[0])
    if not nvmelist:
       return NULL
    for device in nvmelist:
        device_list.append( '/dev/{}'.format(device))
    return device_list


def act_initialize_ssd(device_list):
    for _ssd in device_list:
        cmd = "sudo ./actprep {} ".format(_ssd)
        try:
            subprocess.Popen(cmd.split())
            return True
        except Exception, i:
            print '\nException: ', i
            return False

def is_initialize_running():
    cmd = "ps -ef"
    try:
        templine = subprocess.check_output(cmd.split()).splitlines()
        for _temp in templine:
            for __temp in  _temp.split():
                if 'actprep' in __temp:
                    return True
        return False
    except Exception, i:
        print '\nException: ', i
        return False


parser = argparse.ArgumentParser()
parser.add_argument('-device_type', '--device_type', dest='device_type', type=str, default='nvme')
parser.add_argument('-device_list', '--device_list', dest='device_list', type=str)
parser.add_argument('-check_init_status', '--check_init_status', dest='check_init_status', type=bool, default=True)
parser.add_argument('-start_ssd_init', '--start_ssd_init', dest='start_ssd_init', type=bool, default=False)


args = parser.parse_args()

if args.start_ssd_init:
    if args.device_type == "nvme":
        ssd_device_list = get_device_name()
    else:
        ssd_device_list = args.device_list.split()

    if len(ssd_device_list) > 0:
        if not act_initialize_ssd(ssd_device_list):
            print "Fails to initialize device."

if args.check_init_status:
    if is_initialize_running():
        print "SSD init is running."
    else:
        print "SSD init is not running."
