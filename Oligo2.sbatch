#!/bin/bash

#SBATCH --job-name=Oligo
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=64GB
#SBATCH --time=02:00:00
#SBATCH --partition=bigmem
#SBATCH --qos=bigmem

module load R/3.3.0

start=`date +%s`

# preprocessing and differential analysis
R -e "rmarkdown::render('Oligo2.Rmd')"

end=`date +%s`
runtime=$((end-start))
echo runtime: $runtime sec.