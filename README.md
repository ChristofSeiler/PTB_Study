# Immunology Nick

Standard mircroarray workflows on bioconductor:

* https://www.bioconductor.org/help/workflows/arrays/

We will follow the ``oligo`` user guide:

* http://bioconductor.org/packages/release/bioc/vignettes/oligo/inst/doc/oug.pdf

## Howto Use this Repository

The code works best on the Stanford sherlock cluster. We will need about about 24 GB of RAM. On a single core machine the entire workflow including differential and network analysis will take about 30 minutes to complete.

Here are the steps to run it on sherlock. Open a new terminal and run the following commands:

1. login in to sherlock: ``ssh username@sherlock``
2. change to scratch folder: ``cd $SCRATCH``
3. get the latest code from github: ``git clone git@github.com:ChristofSeiler/ImmunologyNick.git``
4. change to folder with code: ``cd ImmunologyNick/``
5. install necessary R packages: ``make install``

Now the code is ready and all necssary R packages are installed. Before we can start the workflow, we need to upload all the .ARR and .CEL files to the sherlock cluster. For this open a new terminal and run the following commands:

1. change to folder with the .ARR and .CEL files: ``cd data_folder/``
2. upload files to sherlock: ``scp *.ARR *.CEL username@sherlock:/scratch/users/username/ImmunologyNick/``

Now open a new terminal and run the following commands to submit the workflow to the cluster:

1. switch to your code folder: ``cd $SCRATCH/ImmunologyNick/``
2. start workflow: ``make Oligo.html``
3. check progress: ``squeue | grep ${USER}``

When job is done the command ``squeue | grep ${USER}`` will return nothing. If sucessful you can find the output of the workflow in two html files:

1. ``Oligo.html``: contains the differential analysis results (including some quality checking)
2. ``NetworkAnalysis.html``: contains the network analysis

Intermerdicate results are save in ``eset.Rdata`` and ``Case.Control_Mock_H1N1_results.csv`` files for further local processing. To download the results to your laptop open a new terminal and run the following commands:

1. change to download folder: ``cd download_folder``
2. download from sherlock: ``scp username@sherlock:/scratch/users/username/ImmunologyNick/*.html .``

Done.

## Problem with P-Value Distribution

Some of the p-value distributions are hill shaped or monotone increasing. They should be uniform in the null case. Or have a peak on the left in case of the alternative case.

According to https://support.bioconductor.org/p/71438/, hill shaped distribution are caused by a wrong dispersion estimate during empirical Bayes and can be be fixed using the package ``fdrtool``. Here some background material:

* Efron: [Microarrays, Empirical Bayes and the Two-Groups Model](https://arxiv.org/abs/0808.0572)
* Efron's book on large inference in chapter 6
* Lecture notes (section 5): http://www-huber.embl.de/users/klaus/Teaching/Testing-lab.pdf
* Recent paper: [P-value calibration for multiple testing problems in genomics](https://www.degruyter.com/view/j/sagmb.2014.13.issue-6/sagmb-2013-0074/sagmb-2013-0074.xml)
* Multiple dispersion parameters: http://www-huber.embl.de/pub/pdf/Reyes2013.pdf

According to https://support.bioconductor.org/p/71438/ and https://support.bioconductor.org/p/35556/, monotone increasing histogram might in fact be due to unexplained covariates.
