#!/bin/bash

INSTALL_DIR=$SCRATCH

# install pandoc to knit Rmd
R_STUDIO=$INSTALL_DIR/rstudio-server-rhel
mkdir $R_STUDIO
cd $R_STUDIO
wget https://download2.rstudio.org/rstudio-server-rhel-0.99.903-x86_64.rpm
rpm2cpio rstudio-server-rhel-0.99.903-x86_64.rpm | cpio -idmv
echo "export PATH=${R_STUDIO}/usr/lib/rstudio-server/bin/pandoc:\$PATH" >> ~/.bash_profile
source ~/.bash_profile

# install R/Bioconductor packages
module load R/3.3.0
R -e "source(\"https://bioconductor.org/biocLite.R\"); biocLite(c(\"oligo\",\"limma\",\"hta20sttranscriptcluster.db\",\"BiocParallel\",\"STRINGdb\",\"BioNet\",\"KEGGREST\"),suppressUpdates=TRUE); install.packages(c(\"pheatmap\",\"RColorBrewer\",\"ggplot2\",\"stringr\",\"igraph\",\"visNetwork\",\"rmarkdown\",\"xml2\",\"ggfortify\",\"magrittr\",\"ff\",\"foreach\",\"doMC\"),repos='http://cran.us.r-project.org')"