#!/bin/bash
set -x
SCIDB_VER=18.1
date
cat /proc/cpuinfo
cat /proc/meminfo
/opt/scidb/$SCIDB_VER/bin/scidb --version
/opt/scidb/$SCIDB_VER/bin/shim -v
cat /opt/scidb/$SCIDB_VER/etc/config.ini
cat /var/lib/shim/conf

echo "Time a simple build query"
time /opt/scidb/$SCIDB_VER/bin/iquery -aq "build(<val:double>[i=0:3], i)"

echo "Two methods for checking if data-disks are SSD-s or HDD: 1 for hard disks and 0 for a SSD."
# http://fibrevillage.com/storage/599-how-to-tell-if-a-disk-is-ssd-or-hdisk-on-linux
lsblk -d -o name,hctl,rota
for diskname in `ls /sys/block/`; do echo $diskname; cat /sys/block/$diskname/queue/rotational; done
