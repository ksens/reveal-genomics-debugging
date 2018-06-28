##################################################
# Redimension `RNAQUANTIFICATION`
rm(list=ls())
library(scidb4gh)
options(scidb.debug=FALSE)
db = scidbconnect()

namespace="public" 

reconfigure_rnaq = function(suffix, schema) {
  query = paste0("create array ", namespace, ".RNAQUANTIFICATION", suffix, 
                 schema)
  tryCatch({iquery(db, query)}, error = function(e) {cat("Array already created\n")})
  
  
  for (i in 1:3000) {
    if (i == 7) {
      cat("Skipping pipeline:", i, "\n")
      next
    }
    cat("Working on pipeline:", i, "\n")
    cat("Number of expression values:", 
        iquery(db, 
              paste0("op_count(filter(", namespace, ".RNAQUANTIFICATION, 
                     measurementset_id=", i, "))"),
              return = T)$count,
        "\n")
    query = paste0(
      "insert(
      repart(
      filter(", namespace, ".RNAQUANTIFICATION, 
      measurementset_id=", i, "), ", namespace, ".RNAQUANTIFICATION", suffix, "), ",
      namespace, ".RNAQUANTIFICATION", suffix, ")")
    iquery(db, query)
  }
}

t1 = proc.time()
reconfigure_rnaq(suffix = "_v2",
                 schema = "<value:float COMPRESSION 'zlib'> 
                 [dataset_version=0:*:0:1;  
                 dataset_id=0:*:0:1; 
                 measurementset_id=0:*:0:1;
                 biosample_id=0:*:0:128; 
                 feature_id=0:*:0:16384]")
proc.time() - t1

cat("Try new configuration parameters for gene-expression array\n")
iquery(db, "rename(RNAQUANTIFICATION, RNAQUANTIFICATION_bak)")
iquery(db, "rename(RNAQUANTIFICATION_v2, RNAQUANTIFICATION)")

# Now try your UI, and note if the gene-expression download timings have improved