## Run fio :  fio trial.fio --output-format=json --output test.log
[globalbbbb]
size=1024m
directory=/mnt/elastifile/
iodepth=16
direct=1
numjobs=8
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
rw=randrw
blocksize=1M
rwmixread=70
rwmixwrite=30

[randrwiops]
rw=randrw
blocksize=4k
rwmixread=70
rwmixwrite=30
