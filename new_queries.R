# find all samples in all dataset that has gene “TGFB1” expression value > 100
rm(list=ls())
library(scidb4gh)
con = gh_connect2()
db = con$db

#### USER PARAMETERS ####
lo_thresh = 2
gene_symbol = c('IGLC4', 'AC034198.7')

rnaq_arr = scidb4gh:::full_arrayname(.ghEnv$meta$arrRnaquantification)
ftr_arr  = scidb4gh:::full_arrayname(.ghEnv$meta$arrFeature)

feature_subquery = paste0("gene_symbol='", gene_symbol, "'", collapse = " OR ")
selection_q = paste0(
          "cross_join(
              filter(", rnaq_arr, ", value > ", lo_thresh, ") as X, ",
                     "filter(", ftr_arr, ", ", feature_subquery, ") as Y, ",
                     "X.feature_id, Y.feature_id)")
res = 
  iquery(con$db, 
       paste0(
         "aggregate(", selection_q, ", count(*), biosample_id)"),
       return = T)
   
biosample_ids = res$biosample_id
cat("The biosample ids that match user specified criteria are: ", pretty_print(biosample_ids), 
    "\nRetrieving the phenotype metadata for these samples\n")
print(get_biosamples(biosample_id = biosample_ids, con = con))

#### Query 2 ####

# search for the measurement data without specifying the measurement set. 
# ... limit the total number of rows retrieved, 
# or only return the first N rows.

#### USER PARAMETERS ####
lo_thresh = 2
gene_symbol = c('IGLC4', 'AC034198.7')
N = 1000


feature_subquery = paste0("gene_symbol='", gene_symbol, "'", collapse = " OR ")

# then
selection_q = paste0(
  "cross_join(", rnaq_arr, " as X, ",
  "filter(", ftr_arr, ", ", feature_subquery, ") as Y, ",
  "X.feature_id, Y.feature_id)")
limit_q = paste0("limit(", selection_q, ",", N, ")")

res = 
  iquery(con$db, 
         limit_q,
         return = T)
print(res)
