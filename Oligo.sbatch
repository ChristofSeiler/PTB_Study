#!/bin/bash

#SBATCH --job-name=Oligo
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=48GB
#SBATCH --time=01:00:00
#SBATCH --partition=bigmem
#SBATCH --qos=bigmem

module load R/3.3.0

start=`date +%s`

R -e "rmarkdown::render('Oligo.Rmd')"
#R -e "rmarkdown::render('NetworkAnalysis.Rmd')"

end=`date +%s`
runtime=$((end-start))
echo runtime: $runtime sec.