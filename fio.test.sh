#!/bin/bash

# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Run one cli to upgrade image on multiple CfMs defined in cfmfile.
# If # is added in front of mgmt_ip in cfmfile, this cfm will be skipped.

#if [ $# -ne 2 ]; then
#echo "Usage: fiobatch.sh fiobatchtest.log fiobatch.cfg"
#echo "cfgfile defines the list of CfM with mgmt ipv4, and platform"
#echo "Example:  ./upgradecfm.sh  hosts.bst.txt  R64-10176.0.0"
#"
#exit $ERR
#fi

cd /mnt
for pattern in read write rw randread randwrite randrw
do for iodepth in 128
   do for blocksize in  32k
      do for filesize in 1024M
         do for numjobs in 16
            do NOW=$(date +"%m.%d.%Y")
            HOSTNAME=$(hostname)
            fio --name=$pattern.data --iodepth=$iodepth --rw=$pattern --bs=$blocksize  \
                        --direct=1 --size=$filesize --numjobs=$numjobs  --fsync=1 --do_verify=1 --verify_fatal=1 \
                        --rwmixread=70 --rwmixwrite=30 --group_reporting --time_based --runtime=600 \
                        --output=fio.$pattern.$iodepth.$blocksize.$filesize.$numjobs.$NOW.$HOSTNAME.log
            rm -rf $pattern.data.*
            done
         done
       done
   done
done
