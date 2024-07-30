# Compacting and refactoring Docker images 
Often times the size of a docker image is substantially greater than what
one would expect it to be based on the program(s) that are being containerised.
Our suspicions are proven right when we attempt some basic modifications that end up
trimming off gigabytes of bloat from the final image. These are some notes and case
examples that have aided me along the way. 

[A really nice walk through which helped me a lot](https://uwekorn.com/2021/03/01/deploying-conda-environments-in-docker-how-to-do-it-right.html). An additional post [here](https://jcristharif.com/conda-docker-tips.html) for more reference. 

As an example we'll look at the software [LongQC](https://github.com/yfukasawa/LongQC), which undertakes quality control of Oxford Nanopore sequencing reads.

I pulled the image and built it locally with Docker, resulting in a final image size of ~3.2GB. Taking a look at the [Dockerfile](https://github.com/yfukasawa/LongQC/blob/master/Dockerfile) of the original longQC, there are a few sections which can be streamlined. 

## Base image 
The base image used is miniconda3 - which *must* be minimal, right? When we
build it out it occupies ~1.7 GB by itself. Instead, we will exchange this with
[mambaforge](https://hub.docker.com/r/condaforge/mambaforge), a smaller build
which uses the mamba resolver and retains most of the ordinary `conda
<options>` functionality. This can be stripped down even further, as outlined in the walk through above. As mambaforge comes preloaded with the condaforge channel, there is no need to explicitly add condaforge later one. 
```Dockerfile
# old 
FROM continuumio/miniconda3
# new 
FROM condaforge/mambaforge
```

## Dependencies 
The original Dockerfile for longQC list the depencies as such;
```Dockerfile
### install LongQC's dependency ###
RUN conda config --add channels conda-forge && \
    conda config --add channels bioconda && \
    conda install -y \
    python=3.9 \
    numpy \
    pandas'>=0.24.0' \
    scipy \
    jinja2 \
    h5py \
    matplotlib'>=2.1.2' \
    scikit-learn && \
    conda install -y -c bioconda \
    edlib \
    pysam \
    python-edlib
```
Since we already have condaforge, we can remove this line, and for testing purposes, we can try remove bioconda and all the dependencies may already be accessible via condaforge. Including the `python=3.9` specifier led to conflicts with the base image which already had `python=3.10` installed, so this was removed. A big thing to take notice of is the absence of any `--clean` like commands at the tail of the installation. These can often trim down many mBs of unneeded files -- we'll add these in. 

Slightly modified, our new code block looks like. The final Dockerfile can be found [here](https://github.com/yfukasawa/LongQC/blob/master/Dockerfile).
```Dockerfile
RUN mamba install -y \
   #python=3.9 builds without 3.9 \
    numpy \
    pandas'>=0.24.0' \
    scipy \
    jinja2 \
    h5py \
    matplotlib'>=2.1.2' \
    scikit-learn && \
    mamba install -y -c bioconda \
    edlib \
    pysam \
    python-edlib && \
    mamba clean --all --yes && \
    conda clean --all --yes
```

With those modifications, that's it! We changed very little, barely undertook
any work, and slimmed down the final image by ~1 GB. If one wanted to get into
the cracks of it, i'm sure this could be pruned even further; but to get a
sample look at just what is occupying the space, by running `sudo docker
history longqc_mamba`, we get this output, which I'm just sampling here for demonstration. 
```
IMAGE          CREATED       CREATED BY                                      SIZE      COMMENT
bdcd957a4ec8   11 days ago   /bin/sh -c mamba install -y     numpy     pa…   1.43GB
```

The dependencies block of the dockerfile is responsible for 1.43 of the space, which is most of the final image. How do we bring this down? 




