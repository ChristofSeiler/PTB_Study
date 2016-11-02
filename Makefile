# differential analysis
Oligo.html: Oligo.sbatch Oligo.Rmd
	sbatch Oligo.sbatch

# install and download resources
install:
	bash Installation_R_only.bash

# get cluster update
check:
	squeue | grep ${USER}

# clean up
clean:
	rm Oligo.html
	rm slurm-*.out
	rm *_results.csv
