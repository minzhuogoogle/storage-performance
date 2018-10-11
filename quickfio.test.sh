#!/bin/bash

# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#


for pattern in read write randrw
do for iodepth in  8
   do for blocksize in  1M 4k
      do for filesize in 1024M
         do for numjobs in 8
            do NOW=$(date +"%m.%d.%Y")
            HOSTNAME=$(hostname)
            fio --name=$pattern.data --iodepth=$iodepth --rw=$pattern --bs=$blocksize  \
                        --direct=1 --size=$filesize --numjobs=$numjobs \
                        --refill_buffers --norandommap --randrepeat=0 \
                        --rwmixread=70 --rwmixwrite=30 --group_reporting --output-format=json \
                        --output=qfio.$pattern.$iodepth.$blocksize.$filesize.$numjobs.$NOW.$HOSTNAME.log
            rm -rf $pattern.data.*
            done
         done
       done
   done
done
