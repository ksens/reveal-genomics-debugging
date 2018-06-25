# Debugging issues with REVEAL/Genomics API

Run the following files in order to provide useful statistics to Paradigm4 customer solutions team.

1. `debug.sh` 

Collects config file parameters, hardware configuration etc.

Run the following on the scidb server:

```sh
git clone https://github.com/ksens/reveal-genomics-debugging.git
cd reveal-genomics-debugging
sudo su - # change to root user
bash debug.sh > /tmp/debug.log 2>&1
```

2. `debug.R`

This script collects basic query timing, and summary statistics about gene-expression and feature array.

Run the following on the client connecting to scidb

```sh
R --slave -e "source('debug.R')" > /tmp/debug_r.log 2>&1
```
