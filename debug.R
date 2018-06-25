#############################
#' R script for collecting array statistics related to 
#' gene-expression download
#############################
rm(list=ls())
library(scidb)
library(dplyr)
options(scidb.debug = FALSE)
db = scidbconnect()

#' Time a simple build query
cat("=========\n")
cat("t1: Time a simple build query\n")
t1 = system.time({iquery(db, "build(<val:double>[i=0:3], i)", return = T)})
print(t1)

#' Schema for gene-expression array
cat("=========\n")
cat("r0: Schema for gene-expression array\n")
r0 = iquery(db, "show(public.RNAQUANTIFICATION)", return = T)
print(r0)

#' Summary statistics for gene-expression array
cat("=========\n")
cat("r1: Summary statistics for gene-expression array\n")
r1 = iquery(db, "summarize(public.RNAQUANTIFICATION)", return = T)
print(r1)

#' Summary statistics for gene-expression array (per instance)
cat("=========\n")
cat("r2: Summary statistics for gene-expression array (per instance)\n")
r2 = iquery(db, "summarize(public.RNAQUANTIFICATION, by_instance:true)", 
            return = T)
print(r2)

#' Summary statistics for gene-expression array (per attribute)
cat("=========\n")
cat("r2b: Summary statistics for gene-expression array (per attribute)\n")
r2b = iquery(db, "summarize(public.RNAQUANTIFICATION, by_attribute:true)", 
            return = T)
print(r2b)



#' Aggregate gene-expression array by study
cat("=========\n")
cat("r3: Aggregate gene-expression array by study\n")
r3 = iquery(db, "aggregate(public.RNAQUANTIFICATION,
                      count(*), dataset_id)", return = T)
print(r3)

#' Aggregate gene-expression array by pipeline
cat("=========\n")
cat("r4: Aggregate gene-expression array by pipeline\n")
r4 = iquery(db, "aggregate(public.RNAQUANTIFICATION,
                      count(*), measurementset_id)", return = T)
print(as_tibble(r4))

#' Aggregate gene-expression array by sample
cat("=========\n")
cat("r5: Aggregate gene-expression array by sample\n")
r5 = iquery(db, "aggregate(public.RNAQUANTIFICATION,
                      count(*), biosample_id)", return = T)
print(as_tibble(r5))

#' Aggregate gene-expression array by feature
cat("=========\n")
cat("r6: Aggregate gene-expression array by feature\n")
r6 = iquery(db, "aggregate(public.RNAQUANTIFICATION,
                      count(*), feature_id)", return = T)
print(as_tibble(r6))

#' Summary statistics for feature array
cat("=========\n")
cat("rf1: Summary statistics for feature array\n")
rf1 = iquery(db, "summarize(public.FEATURE)", return = T)
print(rf1)

#' Summary statistics for feature array (per instance)
cat("=========\n")
cat("rf2: Summary statistics for feature array (per instance)\n")
rf2 = iquery(db, "summarize(public.FEATURE, by_instance:true)", 
             return = T)
print(rf2)

#' Aggregate features by featureset
cat("=========\n")
cat("rf3: Aggregate features by featureset\n")
rf3 = iquery(db, "aggregate(public.FEATURE,
                       count(*), featureset_id)", return = T)
print(rf3)

#' Now save the workspace
cat("=========\n")
cat("Saving workspace\n")
save(list = ls(), file = '/tmp/array_stats.Rda')