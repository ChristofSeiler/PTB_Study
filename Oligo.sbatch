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

# network analysis
fdr=0.0000001
for csv_file_name in *_results.csv
do
    length=${#csv_file_name}
    end=`expr $length-12`
    prefix=${csv_file_name:0:end}
    echo ${prefix} at fdr = $fdr
    echo R -e "rmarkdown::render('NetworkAnalysis.Rmd',output_file = '${prefix}_NetworkAnalysis.html',params = list(csv_file_name = '${csv_file_name}',fdr = '${fdr}'))"
done

end=`date +%s`
runtime=$((end-start))
echo runtime: $runtime sec.