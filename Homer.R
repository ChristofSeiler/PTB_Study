source("http://bioconductor.org/biocLite.R")
biocLite("affy")
biocLite("oligo")
biocLite("limma")

library(affy)
#Affy package doesn't work for HTA arrays, but the Oligo package has support
setwd('~/Desktop/HTAdata')
library(oligo)
library(bigmemory)
celFiles <- list.celfiles()
affyRaw <- read.celfiles(celFiles)
eset <- rma(affyRaw, target = 'core')
#eset is an ExpressionSet, which appears to be a commonly used file format
#in Bioconductor packages that deal with sequencing data
write.exprs(eset,file="data_core_genes.txt")
#output is a huge file that needs annotation.

#pd.hta.2.0 is the annotation package
biocLite("pd.hta.2.0")
library(pd.hta.2.0)
library(help=pd.hta.2.0)
library(annotate)
my_frame <- data.frame(exprs(eset))
str(my_frame)

load(paste0(path.package("pd.hta.2.0"), "/extdata/netaffxTranscript.rda"))
#none of the below code appears to work, as the pd.hta.2.0 package doesn't
#do the same things as the example package
Annot <- data.frame(ACCNUM=sapply(contents(pd.hta.2.0ACCNUM), paste, collapse=", "), 
                    SYMBOL=sapply(contents(pd.hta.2.0SYMBOL), paste, collapse=", "), 
                    DESC=sapply(contents(pd.hta.2.0GENENAME), paste, collapse=", "))
