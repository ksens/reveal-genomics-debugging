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

reconfigure_rnaq(suffix = "_v2",
                 schema = "<value:float COMPRESSION 'zlib'> 
                 [dataset_version=0:*:0:1;  
                 dataset_id=0:*:0:1; 
                 measurementset_id=0:*:0:1;
                 biosample_id=0:*:0:1000; 
                 feature_id=0:*:0:1000]")

reconfigure_rnaq(suffix = "_v3",
                 schema = "<value:float COMPRESSION 'zlib'> 
                 [dataset_version=0:*:0:1;  
                 dataset_id=0:*:0:1; 
                 measurementset_id=0:*:0:1;
                 biosample_id=0:*:0:128; 
                 feature_id=0:*:0:32768]")

reconfigure_rnaq(suffix = "_v4",
                 schema = "<value:float COMPRESSION 'zlib'> 
                 [dataset_version=0:*:0:1;  
                 dataset_id=0:*:0:1; 
                 measurementset_id=0:*:0:1;
                 biosample_id=0:*:0:32768; 
                 feature_id=0:*:0:128]")
