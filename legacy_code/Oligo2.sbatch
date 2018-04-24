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
prefix=time_to_delivery
fdr=0.05
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"

prefix=H1N1
fdr=0.05
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"

prefix=gestage_delivery
fdr=0.05
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"

prefix=time_to_delivery_H1N1
fdr=0.05
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"

prefix=H1N1_gestage_delivery
fdr=0.05
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"

end=`date +%s`
runtime=$((end-start))
echo runtime: $runtime sec.