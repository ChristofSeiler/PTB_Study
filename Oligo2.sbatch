#!/bin/bash

#SBATCH --job-name=Oligo
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=02:00:00
#SBATCH --partition=bigmem
#SBATCH --qos=bigmem

module load R/3.3.0

start=`date +%s`

# preprocessing and differential analysis
R -e "rmarkdown::render('Oligo2.Rmd')"

# network analysis for interaction term
prefix=gestage_enroll
fdr=0.05
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"

prefix=H1N1
fdr=0.05
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"

prefix=gestage_enroll_H1N1
fdr=0.05
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"

end=`date +%s`
runtime=$((end-start))
echo runtime: $runtime sec.