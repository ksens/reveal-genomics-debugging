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
time /opt/scidb/$SCIDB_VER/bin/iquery -aq "build(<val:double>[i=0:3], i)"
