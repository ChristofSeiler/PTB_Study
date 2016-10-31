source("http://bioconductor.org/biocLite.R")
biocLite("affy")
biocLite("oligo")
biocLite("limma")
install.packages("hta20stprobeset.db")

library(affy)
#Affy package doesn't work for HTA arrays, but the Oligo package has support
setwd('~/Desktop/HTAdata')
library(oligo)
library(bigmemory)

#read in metadata from .ARR companion files
dir <- getwd()
fls <- list.files(dir, pattern = "ARR", full=TRUE)
readArr(fls[[1]])
arr <- readArr(fls)

#read in raw array data as .CEL files
celFiles <- list.celfiles()
affyRaw <- read.celfiles(celFiles)
eset <- rma(affyRaw, target = 'core')
#eset is an ExpressionSet, which appears to be a commonly used file format
#in Bioconductor packages that deal with sequencing data
write.exprs(eset,file="data_core_genes.txt")
#output is a huge file that needs annotation.

library(hta20stprobeset.db)
#lists info about the probeset database
hta20stprobeset()
my_frame <- data.frame(exprs(eset))

sns <- sampleNames(eset)



Annot <- data.frame(ACCNUM=sapply(contents(hta20stprobesetACCNUM), paste, collapse=", "), 
                    SYMBOL=sapply(contents(hta20stprobesetSYMBOL), paste, collapse=", "), 
                    DESC=sapply(contents(hta20stprobesetGENENAME), paste, collapse=", "))

all <- merge(Annot, my_frame, by.x=0, by.y=0, all=T)
