# Notes on nf-core tools from Nextflow

## Resources used 
* [Nextflow and nf-core Online Community Training - Session 2 (English)](https://www.youtube.com/watch?v=ZD0SBjMUy4w)  
* [Nextflow and nf-core Online Community Training - Session 3 (English)](https://www.youtube.com/watch?v=APavyRs4OMY&t=61s)   


## Basic Commands
* `nf-core list` will list all the available nf-core pipelines.   
* `nf-core install` will download and install pipelines.  
* `nf-core modules install <module>` will download and install modules.   
* `nf-core lint` will perform quality checks on pipeline to ensure the adherence to best practices.    


## Config files 
* There are various config files found in the `/conf` directory
of your workflow. Pay attention to the modules.config if you are
a developer as this where we set the options for the specific
modules and software that we use. The igenomes.config is
automatically included in all nf-core templates -- this will
contain prefilled reference genomes which are hosted externally.
An institution/cluster specific config file containing executor
information and additional parameters should be provided here and
use when running pipelines using these clusters. These specific config profiles are then provided to the executor as `--profile bunya.config`.          


## Params file 
* If we would like to repeatedly run a specific combination of
options in our workflow, which can be easily encapsulated and
reproduced, we should create a `my_run_params.json` file which
lists the specific options used. The .json is then provided to
the executor when we run the pipeline, using the `--params-file`
option.    
* nf-core contain an `nf-core launch` program which allows users to easily, and interactively, construct a custom params file for a workflow which corresponds to the exact options one needs; e.g. this genome, this index, these UMIs and so on. [See more here](https://nf-co.re/launch).        

## Offline usage 
If we anticipate that we won't have internet access when running the pipeline, we can download the entire nf-core pipeline locally, including all the test data and container images, allowing us to run it anywhere we need. This can be perform with `nf-core download <pipeline name>`.     

## Linting 
* To check our pipeline against nextflows community best practices, we undertake 'linting' - a series of checks will be performed to ensure that files are in their correct location, they are present where they should be present and so on -- ``nf-core lint`    
* Custom workflows which are not intended to be used as official nf-core pipeline, will often fail linting due to the various modifications which will be made to 'de-officialize' the default nf-core template. See [guidelines](https://nf-co.re/docs/contributing/tutorials/unofficial_pipelines) for additional recommendations.     
* The python tool **prettier** can be used to check the formatting of our markup files, these including markdown files. It is run by using `prettier -c .`. See for [more](https://nf-co.re/docs/contributing/code_formatting).     
*

## Schema JSON
* A `nextflow_schema.config` describes the input parameters that the pipeline accepts. It is often [built](https://nf-co.re/pipeline_schema_builder) using the interactive nf-core tool `nf-core schema build`.    

## Modules 
* To list all the available nf-core modules run `nf-core modules list`   
* Installing a module is as easy as `nf-core modules install <module>`   
* Updating can be done by `nf-core modules update <module>`     
* Many other functions such as `lint`, `patch`, `test`, `remove` and so on are availabe for implementing, testing and tweaking the modules
* `modules.json` is a metadata file which tracks the modules which the pipeline has installed.     
* Creating ones own module is undertaken with `nf-core modules create`. A
prompt will ask us to name the module, followed by a prompt which asks for the
installation of specific tools e.g. samtools to use in our module, thereafter
nf-core will ask which labels we would like to use for the module e.g. high
mem, low-cpu etc. A list of TO-DOs will be created, if linting is enabled, and
some templates automatically created.   

## Sub-workflows 
* These are varitions of a program, often implementing a very specific
option/feature of a program e.g. GATK call, rather than all of GATK.    
* The nf-core subworkflows are listed with `nf-core subworkflows list`, and
essentially, most of the options and functions of the `nf-core modules` are
also available to `nf-core subworkflows` e.g. linting, remove, test and so on.   
* Subworkflows are used in our pipeline in a similar way to modules. Their
structure is somewhat different, as they use `take` and `emit` rather than
`input` and `output`.    

## Containers and Environments
* As an ethod of nextflow is reproducibility and containerisations, our processes will often use programs that are packaged neatly in images/containers.   

### Docker
* Docker is a common container software which encapsulates almost any program we can think of, in a closed and contained (no pun) way.  
* There are many containers which are pre-built and provided on docker and other repositories, so more often than not we don't need to build our own images.  
* In the case that we do need to build our own image and container, there is a handy tutorial on the [nextflow training](https://training.nextflow.io/basic_training/containers/#add-a-software-package-to-the-image) website.    
* In brief, we a) Run docker locally, pull an operating system base of our
desire, such as debian, b) create a dockerfile to build our image, c) build the
image, d) download our desired software (with the correct mount paths) and
rebuild the image... proceeed.   
* Often times, if we build the image naively, we can forget to provide the appropriate mount paths, causing the programs to fail. 
* Once your custom container is built, we can upload it to the docker/quay repository.    
* If our program is contained within the container, and is not downloaded locally and specified in config file, we can simply run our nextflow script in a barebone form as such `nextflow run script.nf -with-docker <image>`. If using a singularity container, the only different is that we provide `-with-sigularity` instead.    

### Conda
* Conda is used mostly as an environment for python programs (or ones that have been ported to python). 
* In nextflow we can create a conda environment in much the same way as one
would on the command line bash, `conda init`, followed by `bash` and `conda env
create --file env.yml` whereby the channels, programs (and versions),
dependencies are listed. Conda environment will then be created based upon
what's found in this YAML file.    
* To then use the programs within this conda envivornment, we run the nextflow script much like we do with the containers; `nextflow run script2.nf -with-conda <path/to/condanev>.    
* Micromamba is much better imo, but the installation is a bit more complicated
as we first need to install mamba using a docker environment, and install the
conda programs within this dockerfile.     

### Biocontainers
* Biocontainers in another repository/registry of containers tailed specifically to bioinformatics tools.
* An interesting aspect of the biocontainers images is that they can come
packaged as multi-tool images, minimizing the need to provide information for
several inter-related containers used in a specific pipeline e.g. fastqc is
often going to be used with cutadapt. 
* `docker pull biocontainers/fastqc:v0.11.5`      
*





