#!/bin/bash

#SBATCH --job-name=Oligo
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=32GB
#SBATCH --time=04:00:00
#SBATCH --partition=normal

module load R/3.3.0

start=`date +%s`

# plan 1
plan=plan_1
fdr=0.0000001
R -e "rmarkdown::render('Oligo.Rmd',output_file = 'Oligo_${plan}.html',params = list(plan = '${plan}'))"
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = 'NetworkAnalysis_${plan}.html',params = list(plan = '${plan}',fdr = '${fdr}'))"

# plan 2
plan=plan_2
fdr=0.0000001
R -e "rmarkdown::render('Oligo.Rmd',output_file = 'Oligo_${plan}.html',params = list(plan = '${plan}'))"
R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = 'NetworkAnalysis_${plan}.html',params = list(plan = '${plan}',fdr = '${fdr}'))"

end=`date +%s`
runtime=$((end-start))
echo runtime: $runtime sec.