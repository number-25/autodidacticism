# Notes on nf-core tools from Nextflow

## Resources used 
[Nextflow and nf-core Online Community Training - Session 2 (English)](https://www.youtube.com/watch?v=ZD0SBjMUy4w)

## Basic Commands
* `nf-core list` will list all the available nf-core pipelines.   

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



