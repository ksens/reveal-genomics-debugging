# Debugging issues with REVEAL/Genomics API

Run the following files in order to provide useful statistics to Paradigm4 customer solutions team.

## 1. `debug.sh` (on the scidb server)

Run on the scidb server:

```sh
# Collects config file parameters, hardware configuration etc.
git clone https://github.com/ksens/reveal-genomics-debugging.git
cd reveal-genomics-debugging
sudo su - # change to root user
bash debug.sh > /tmp/debug.log 2>&1
```

## 2. `debug.R` (on the client machine)

First make sure the file runs via RStudio -- you will need to change the following user parameters within the R file

```R
host = 'localhost'
dataset_id = 1 # the study id for which download is slow
measurementset_id = 1 # the measuremntset_id (pipeline id) for which download is slow
gene_symbol = 'IGLC4' # replace by any gene of interest e.g. 'EGFR', 'KRAS' etc.
```

Then collect the metrics by running the script. 

```sh
# This script collects basic query timing, and summary statistics about gene-expression and feature array.
R --slave -e "source('debug.R')" > /tmp/debug_r.log 2>&1
# Store the two outputs into a tar file
tar -cvf /tmp/debug.tar /tmp/debug_array_stats.Rda /tmp/debug_r.log
```

## 3. email Paradigm4 customer solutions

Email the two files to customer solutions

- `/tmp/debug.log` from the scidb server
- `/tmp/debug.tar` from the client machine
