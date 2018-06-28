#############################
#' R script for collecting array statistics related to 
#' gene-expression download
#############################
rm(list=ls())
library(scidb4gh)
cat("Turning on scidb debugging\n")
options(scidb.debug = TRUE)

#### USER SPECIFIC PARAMETERS #######
host = 'localhost'
dataset_id_1 = 1 # id for a study of interest
dataset_id_2 = 1 # id for another study of interest
#-----------------------------------#

gh_connect(host = host, port = 8080)
db = scidbconnect(host = host)

################################ PART 3 ############################################################

cat("************************** PART 3 **************************\n")

# Phenotype data: Individuals 
cat("=====\n")
cat("Individuals for dataset_id:", dataset_id_1, "\n")
print(system.time({
  i1 = search_individuals(dataset_id = dataset_id_1)
}))
print(object.size(i1))
print(dim(i1))

cat("-----\n")
cat("Individuals for dataset_id:", dataset_id_2, "\n")
print(system.time({
  i2 = search_individuals(dataset_id = dataset_id_2)
}))
print(object.size(i2))
print(dim(i2))

# Phenotype data: Biosamples
cat("=====\n")
cat("Biosamples for dataset_id:", dataset_id_1, "\n")
print(system.time({
  b1 = search_biosamples(dataset_id = dataset_id_1)
}))
print(object.size(b1))
print(dim(b1))

cat("-----\n")
cat("Biosamples for dataset_id:", dataset_id_2, "\n")
print(system.time({
  b2 = search_biosamples(dataset_id = dataset_id_2)
}))
print(object.size(b2))
print(dim(b2))

cat("Turning off scidb debugging\n")
options(scidb.debug = FALSE)

