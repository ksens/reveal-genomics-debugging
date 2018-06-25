#############################
#' R script for collecting array statistics related to 
#' gene-expression download
#############################
rm(list=ls())
library(scidb)
options(scidb.debug = FALSE)
db = scidbconnect()

# Time a simple build query
t1 = system.time({iquery(db, "build(<val:double>[i=0:3], i)", return = T)})
print(t1)

#' Summary statistics for gene-expression array
r1 = iquery(db, "summarize(public.RNAQUANTIFICATION)", return = T)
print(r1)

#' Summary statistics for gene-expression array (per instance)
r2 = iquery(db, "summarize(public.RNAQUANTIFICATION, by_instance:true)", 
            return = T)
print(r2)

#' Aggregate gene-expression array by study
r3 = iquery(db, "aggregate(public.RNAQUANTIFICATION,
                      count(*), dataset_id)", return = T)
print(r3)

#' Aggregate gene-expression array by pipeline
r4 = iquery(db, "aggregate(public.RNAQUANTIFICATION,
                      count(*), measurementset_id)", return = T)
print(r4)

#' Aggregate gene-expression array by sample
r5 = iquery(db, "aggregate(public.RNAQUANTIFICATION,
                      count(*), biosample_id)", return = T)
print(r5)

#' Aggregate gene-expression array by feature
r6 = iquery(db, "aggregate(public.RNAQUANTIFICATION,
                      count(*), feature_id)", return = T)
print(r6)

#' Summary statistics for feature array
rf1 = iquery(db, "summarize(public.FEATURE)", return = T)
print(rf1)

#' Summary statistics for feature array (per instance)
rf2 = iquery(db, "summarize(public.FEATURE, by_instance:true)", 
             return = T)
print(rf2)

#' Aggregate features by featureset
rf3 = iquery(db, "aggregate(public.FEATURE,
                       count(*), featureset_id)", return = T)
print(rf3)

#' Now save the workspace
save(list = ls(), file = '/tmp/array_stats.Rda')