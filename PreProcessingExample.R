library(oligoData)
library(AffyCompatible)
library(ff)
#ff package allows for large dataset manipulation

#affyExpressionFS is an example dataset from the chip maker
data(affyExpressionFS)
sns <- sampleNames(affyExpressionFS)
## all 1521 were meant to be 1251
sns <- gsub('1521', '1251', sns)
## removing the 'r' (repeat) flag from the name
sns <- gsub('r\\.CEL$', '\\.CEL', sns)

#coding in metadata - would be better to find way to read .ARR files
wafer <- substr(sns, 1, 4)
experiment <- substr(sns, 5, 5)
tmp <- substr(sns, 6, 7)
complex <- rep('+', length(tmp))
complex[tmp == '00'] <- '-'
info <- data.frame(wafer=wafer, experiment=experiment, complex=complex)
rownames(info) <- sns
metadata <- data.frame(labelDescription=c('wafer', 'experiment', 'complex'), channel=factor('_ALL_'))
sampleNames(affyExpressionFS) <- sns
pd <- new('AnnotatedDataFrame', data=info, varMetadata=metadata)
phenoData(affyExpressionFS) <- pd
rm(tmp, wafer, experiment, complex, pd, metadata)

#making MA plots - plots log-ratios (M) vs. average log-intensity
xl <- c(2.8, 4)
yl <- c(-1, 1)
MAplot(affyExpressionFS[, 1:3], pairs=TRUE, ylim=yl, xlim=xl)

#background subtraction
backgroundCorrectionMethods()
bgData1 <- backgroundCorrect(affyExpressionFS)
bgData2 <- backgroundCorrect(affyExpressionFS, method='mas')
boxplot(bgData1)
boxplot(bgData2)

#normalization
normData <- normalize(bgData1)

#it seems like the rma() function does background subtraction, normalization
#and summarization

ppData <- rma(affyExpressionFS)
