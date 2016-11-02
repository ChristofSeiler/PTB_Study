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
2. upload files to sherlock (change username): ``scp *.ARR *.CEL username@sherlock:/scratch/users/username/ImmunologyNick/``

Now switch back to the first terminal to submit a cluster job. Open new terminal and run the following commands:

1. switch to your code folder: ``cd $SCRATCH/ImmunologyNick/``
2. start workflow: ``make Oligo.html``
