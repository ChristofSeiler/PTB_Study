#!/bin/bash

#SBATCH --job-name=Oligo
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=16GB
#SBATCH --time=02:00:00
#SBATCH --partition=bigmem
#SBATCH --qos=bigmem

module load R/3.3.0

start=`date +%s`

R -e "rmarkdown::render('Oligo.Rmd')"
#R -e "rmarkdown::render('NetworkAnalysis.Rmd')"

end=`date +%s`
runtime=$((end-start))
echo runtime: $runtime sec.