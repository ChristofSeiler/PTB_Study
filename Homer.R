source("http://bioconductor.org/biocLite.R")
biocLite("affy")
biocLite("oligo")
biocLite("limma")

library(affy)
library(convert)

setwd('~/Desktop/HTAdata')
ReadAffy()

list.celfiles()
