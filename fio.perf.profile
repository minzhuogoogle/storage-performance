[global]
size=1024m
directory=/mnt/fio/
iodepth=16
direct=1
numjobs=4
randrepeat=0

[readbw]
rw=read
blocksize=1M

[readiops]
rw=read
blocksize=4k

[writebw]
rw=write
blocksize=1M

[writeiops]
rw=write
blocksize=4k

[randrwbw]
rw=write
blocksize=1M

[randrwiops]
rw=write
blocksize=4k
