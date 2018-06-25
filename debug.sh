#!/bin/bash
set -x
date
cat /proc/cpuinfo
cat /proc/meminfo
scidb --version
shim -v
cat /opt/scidb/18.1/etc/config.ini
cat /var/lib/shim/conf
time iquery -aq "build(<val:double>[i=0:3], i)"
