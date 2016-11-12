#!/bin/bash

#SBATCH --job-name=Oligo
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=32GB
#SBATCH --time=04:00:00
#SBATCH --partition=normal

module load R/3.3.0

start=`date +%s`

# preprocessing and differential analysis
R -e "rmarkdown::render('Oligo.Rmd')"

# network analysis for 5 contrasts
# contrast 1
prefix=Preterm_vs_Term_for_H1N1
fdr=0.01
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"
# contrast 2
prefix=Preterm_vs_Term_for_Mock
fdr=0.01
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"
# contrast 3
prefix=H1N1_vs_Mock_for_Preterm
fdr=0.001
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"
# contrast 4
prefix=H1N1_vs_Mock_for_Term
fdr=0.000000001
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"
# contrast 5
prefix=H1N1_vs_Mock_for_Preterm_vs_H1N1_vs_Mock_for_Term
fdr=0.01
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"

# fixed effects
prefix=H1N1_vs_Mock_for_Preterm_vs_H1N1_vs_Mock_for_Term_fixed
fdr=0.01
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${prefix}_results.csv',fdr = '${fdr}'))"

end=`date +%s`
runtime=$((end-start))
echo runtime: $runtime sec.